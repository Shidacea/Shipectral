require_relative "utility/rake_helper.rb"

SHIPECTRAL_BUILD_PATH = get_value("SHIPECTRAL_BUILD_PATH", "build")
CRYSTAL_PATH = get_value("CRYSTAL_PATH", nil)

SHIPECTRAL_COMPILER = determine_compiler
puts "Compiler is: #{SHIPECTRAL_COMPILER}"

if !CRYSTAL_PATH && SHIPECTRAL_COMPILER == :msvc
    raise "CRYSTAL_PATH environment variable was not set."
end

CONFIG_FILE = get_value("SHIPECTRAL_CONFIG_FILE", "configs/launshi_sfml.json")

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

task :generate_build_dir => [:load_config] do
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    FileUtils.mkdir_p(SHIPECTRAL_BUILD_PATH)
    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}")
end

task :build_crsfml => [:generate_build_dir, :build_sfml, :load_config] do
    use_sfml = $shipectral_config.get_option_value(:use_sfml)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if use_sfml
        if SHIPECTRAL_COMPILER == :msvc
            puts "Building crSFML..."

            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/crsfml")
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/crsfml/src")
            FileUtils.cp_r "third_party/crsfml/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/crsfml", :verbose => false

            system "utility/compile_crSFML.bat #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}"
        end
    end
end

task :build_sfml => [:generate_build_dir, :load_config] do
    use_sfml = $shipectral_config.get_option_value(:use_sfml)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if use_sfml
        if SHIPECTRAL_COMPILER == :msvc
            puts "Building SFML..."
            
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sfml")

            system "utility/compile_SFML.bat #{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{Dir.pwd}/third_party/SFML"
        end
    end
end

task :build_sdlcr => [:generate_build_dir, :build_sdl, :load_config] do
    use_sdl = $shipectral_config.get_option_value(:use_sdl)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if use_sdl
        if SHIPECTRAL_COMPILER == :msvc
            puts "Building SDL.cr..."

            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdl")
            FileUtils.cp_r "third_party/sdlcr/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdl", :verbose => false
        end
    end
end

task :build_sdl => [:generate_build_dir, :load_config] do
    use_sdl = $shipectral_config.get_option_value(:use_sdl)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if use_sdl
        if SHIPECTRAL_COMPILER == :msvc
            puts "Downloading SDL libraries..."

            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib")

            system "curl https://www.libsdl.org/release/SDL2-devel-2.0.20-VC.zip --output #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2-devel-2.0.20-VC.zip"
            system "curl https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-devel-2.0.4-VC.zip --output #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2_mixer-devel-2.0.4-VC.zip"
            system "curl https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.5-VC.zip --output #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2_image-devel-2.0.5-VC.zip"

            system "powershell.exe -nologo -noprofile -command \"Expand-Archive #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2-devel-2.0.20-VC.zip\" -DestinationPath #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib"
            system "powershell.exe -nologo -noprofile -command \"Expand-Archive #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2_mixer-devel-2.0.4-VC.zip\" -DestinationPath #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib"
            system "powershell.exe -nologo -noprofile -command \"Expand-Archive #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2_image-devel-2.0.5-VC.zip\" -DestinationPath #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib" 
        end
    end
end

task :build_rl_cr => [:generate_build_dir, :build_rl, :load_config] do
    use_rl = $shipectral_config.get_option_value(:use_rl)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)
    
    if use_rl
        if SHIPECTRAL_COMPILER == :msvc
            # TODO
        end
    end
end

task :build_rl => [:generate_build_dir, :load_config] do
    use_rl = $shipectral_config.get_option_value(:use_rl)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if use_rl
        if SHIPECTRAL_COMPILER == :msvc
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/rl_lib")

            system "curl https://github.com/raysan5/raylib/releases/download/4.0.0/raylib-4.0.0_win64_msvc16.zip --output #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/rl_lib/raylib-4.0.0_win64_msvc16.zip"
            system "powershell.exe -nologo -noprofile -command \"Expand-Archive #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/rl_lib/raylib-4.0.0_win64_msvc16.zip\" -DestinationPath #{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/rl_lib"
        end
    end
end

task :build_imgui => [:generate_build_dir, :build_sfml, :build_sdl, :load_config] do
    use_sfml = $shipectral_config.get_option_value(:use_sfml)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if use_sfml
        if SHIPECTRAL_COMPILER == :msvc
            puts "Building imgui..."

            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/imgui-sfml")
            FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/imgui")
            FileUtils.cp_r "third_party/crystal-imgui-sfml/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/imgui-sfml", :verbose => false
            FileUtils.cp_r "third_party/crystal-imgui/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/imgui", :verbose => false

            system "utility/compile_crimgui.bat #{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{CRYSTAL_PATH}"
        end
    end
end

task :build_anyolite => [:generate_build_dir, :load_config] do
    anyolite_config_file = $shipectral_config.get_option_value(:anyolite_config_file)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if SHIPECTRAL_COMPILER == :msvc
        puts "Building Anyolite..."

        FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/anyolite")
        unless File.exist?("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/anyolite/Rakefile.rb")
            FileUtils.cp_r "third_party/anyolite/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/anyolite", :verbose => false
        end

        system "utility/compile_anyolite.bat #{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{Dir.pwd}/#{anyolite_config_file}"
    end
end

task :build_shipectral => [:generate_build_dir, :build_crsfml, :build_sdlcr, :build_sfml, :build_sdl, :build_imgui, :build_anyolite, :build_shards, :load_config] do
    executable_name = $shipectral_config.get_option_value(:executable_name)
    debug = $shipectral_config.get_option_value(:debug)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    build_type = debug ? "-DDEBUG" : "--release"
    script_name = $shipectral_config.get_shipectral_compile_script_name

    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin")

    if SHIPECTRAL_COMPILER == :msvc
        puts "Building Shipectral with MSVC..."

        system "utility/#{script_name}.bat #{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{executable_name} #{build_type} bin #{CRYSTAL_PATH}"
    elsif SHIPECTRAL_COMPILER == :gcc
        puts "Building Shipectral with #{SHIPECTRAL_COMPILER}..."

        system "utility/#{script_name}.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{executable_name} #{build_type} bin"
    end
end

task :install_shipectral => [:build_shipectral, :load_config] do
    install_helper
end

task :build_shards => [:generate_build_dir, :build_sfml, :build_sdl, :load_config] do
    anyolite_config_file = $shipectral_config.get_option_value(:anyolite_config_file)

    # TODO: Ignore SFML and ImGui shards if possible somehow

    if SHIPECTRAL_COMPILER == :gcc
        puts "Building shards..."
        
        system "ANYOLITE_CONFIG_PATH=#{Dir.pwd}/#{anyolite_config_file} ANYOLITE_RB_CONFIG_RELATIVE_PATH=#{Dir.pwd} shards install"
    end
end

task :recompile => [:load_config] do
    executable_name = $shipectral_config.get_option_value(:executable_name)
    debug = $shipectral_config.get_option_value(:debug)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    build_type = debug ? "-DDEBUG" : "--release"
    script_name = $shipectral_config.get_shipectral_compile_script_name

    if SHIPECTRAL_COMPILER == :msvc
        system "utility/#{script_name}.bat #{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{executable_name} #{build_type} bin #{CRYSTAL_PATH}"
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/#{script_name}.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}/#{build_path_name} #{executable_name} #{build_type} bin"
    end

    install_helper
end

task :test => [:load_config] do
    install_helper

    executable_name = $shipectral_config.get_option_value(:executable_name)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if SHIPECTRAL_COMPILER == :msvc
        system "\"#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/#{executable_name}.exe\""
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/run_Shipectral.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin #{executable_name}"
    end
end

task :test_standalone => [:load_config] do
    executable_name = $shipectral_config.get_option_value(:executable_name)
    build_path_name = $shipectral_config.get_option_value(:build_path_name)

    if SHIPECTRAL_COMPILER == :msvc
        system "\"#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/#{executable_name}.exe\""
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/run_Shipectral.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin #{executable_name}"
    end
end