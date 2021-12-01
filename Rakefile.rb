require_relative "utility/rake_helper.rb"

SHIPECTRAL_BUILD_PATH = get_value("SHIPECTRAL_BUILD_PATH", "build")
CRYSTAL_PATH = get_value("CRYSTAL_PATH", "crystal")

SHIPECTRAL_COMPILER = determine_compiler

CONFIG_FILE = get_value("SHIPECTRAL_CONFIG_FILE", "configs/launshi.json")

$shipectral_config = nil

task :default => [:install_shipectral] do
    
end

task :load_config do
    $shipectral_config = ShipectralConfig.new
    $shipectral_config.load_file(CONFIG_FILE)
end

task :clean_all do
    FileUtils.rm_r "#{SHIPECTRAL_BUILD_PATH}" if Dir.exist?("#{SHIPECTRAL_BUILD_PATH}")
    FileUtils.rm_r "lib" if Dir.exist?("lib")
end

task :clean => [:load_config] do
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    FileUtils.rm_r "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}" if Dir.exist?("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}")
end

task :generate_build_dir do
    FileUtils.mkdir_p(SHIPECTRAL_BUILD_PATH)
end

task :build_crsfml => [:generate_build_dir, :build_sfml, :load_config] do
    use_sfml = $shipectral_config.get_option_value(:use_sfml)

    if use_sfml
        if SHIPECTRAL_COMPILER == :msvc
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/crsfml")
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/crsfml/src")
            FileUtils.cp_r "third_party/crsfml/.", "#{SHIPECTRAL_BUILD_PATH}/crsfml", :verbose => true

            system "utility/compile_crSFML.bat #{SHIPECTRAL_BUILD_PATH}"
        end
    end
end

task :build_sfml => [:generate_build_dir, :load_config] do
    use_sfml = $shipectral_config.get_option_value(:use_sfml)

    if use_sfml
        if SHIPECTRAL_COMPILER == :msvc
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/sfml")

            system "utility/compile_SFML.bat #{SHIPECTRAL_BUILD_PATH}"
        end
    end
end

task :build_imgui => [:generate_build_dir, :build_sfml, :load_config] do
    use_sfml = $shipectral_config.get_option_value(:use_sfml)

    if use_sfml
        if SHIPECTRAL_COMPILER == :msvc
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/imgui-sfml")
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/imgui")
            FileUtils.cp_r "third_party/crystal-imgui-sfml/.", "#{SHIPECTRAL_BUILD_PATH}/imgui-sfml", :verbose => true
            FileUtils.cp_r "third_party/crystal-imgui/.", "#{SHIPECTRAL_BUILD_PATH}/imgui", :verbose => true

            system "utility/compile_crimgui.bat #{SHIPECTRAL_BUILD_PATH}"
        end
    end
end

task :build_anyolite => [:generate_build_dir, :load_config] do
    anyolite_config_file = $shipectral_config.get_option_value(:anyolite_config_file)

    if SHIPECTRAL_COMPILER == :msvc
        FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/anyolite")
        unless File.exist?("#{SHIPECTRAL_BUILD_PATH}/anyolite/Rakefile.rb")
            FileUtils.cp_r "third_party/anyolite/.", "#{SHIPECTRAL_BUILD_PATH}/anyolite", :verbose => true
        end

        system "utility/compile_anyolite.bat #{SHIPECTRAL_BUILD_PATH} #{anyolite_config_file}"
    end
end

task :build_shipectral => [:generate_build_dir, :build_crsfml, :build_sfml, :build_imgui, :build_anyolite, :build_shards, :load_config] do
    executable_name = $shipectral_config.get_option_value(:executable_name)
    debug = $shipectral_config.get_option_value(:debug)
    use_sfml = $shipectral_config.get_option_value(:use_sfml)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    build_type = debug ? "-DDEBUG" : "--release"
    script_name = use_sfml ? "compile_Shipectral" : "compile_Shipectral_without_SFML"

    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}")

    if SHIPECTRAL_COMPILER == :msvc
        system "utility/#{script_name}.bat #{SHIPECTRAL_BUILD_PATH} #{executable_name} #{build_type} #{build_path_name}"
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/#{script_name}.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{executable_name} #{build_type}"
    end
end

task :install_shipectral => [:build_shipectral, :load_config] do
    use_sfml = $shipectral_config.get_option_value(:use_sfml)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)
    frontend = $shipectral_config.get_option_value(:frontend)
    copy_frontend_assets_to_build_directory = $shipectral_config.get_option_value(:copy_frontend_assets_to_build_directory)
    frontend_asset_directory = $shipectral_config.get_option_value(:frontend_asset_directory)
    add_demos = $shipectral_config.get_option_value(:add_demos)
    add_project_directory = $shipectral_config.get_option_value(:add_project_directory)

    if use_sfml
        if SHIPECTRAL_COMPILER == :msvc
            FileUtils.cp_r "#{SHIPECTRAL_BUILD_PATH}/sfml/bin/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}", :verbose => true
        else
            FileUtils.cp "#{Dir.pwd}/lib/imgui-sfml/libcimgui.so", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/libcimgui.so", :verbose => true
        end
    end

    if copy_frontend_assets_to_build_directory
        FileUtils.cp_r "#{Dir.pwd}/#{frontend}/#{frontend_asset_directory}/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/#{frontend_asset_directory}", :verbose => true
    end

    if add_demos
        FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/demo_projects")
        FileUtils.cp_r "#{Dir.pwd}/demo_projects/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/demo_projects"
    end

    if add_project_directory
        FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/projects")
    end
end

task :build_shards => [:generate_build_dir, :build_sfml, :load_config] do
    anyolite_config_file = $shipectral_config.get_option_value(:anyolite_config_file)

    # TODO: Ignore SFML and ImGui shards if possible somehow

    if SHIPECTRAL_COMPILER == :gcc
        system "ANYOLITE_CONFIG_PATH=#{Dir.pwd}/#{anyolite_config_file} shards install"
    end
end

task :recompile => [:load_config] do
    executable_name = $shipectral_config.get_option_value(:executable_name)
    debug = $shipectral_config.get_option_value(:debug)
    use_sfml = $shipectral_config.get_option_value(:use_sfml)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    build_type = debug ? "-DDEBUG" : "--release"
    script_name = use_sfml ? "compile_Shipectral" : "compile_Shipectral_without_SFML"

    if SHIPECTRAL_COMPILER == :msvc
        system "utility/#{script_name}.bat #{SHIPECTRAL_BUILD_PATH} #{executable_name} #{build_type} #{build_path_name}"
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/#{script_name}.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{executable_name} #{build_type}"
    end
end

task :test => [:load_config] do
    executable_name = $shipectral_config.get_option_value(:executable_name)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if SHIPECTRAL_COMPILER == :msvc
        system "\"#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/#{executable_name}.exe\""
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/run_Shipectral.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{executable_name}"
    end
end