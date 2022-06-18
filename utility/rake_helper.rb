require 'fileutils'
require 'json'

def get_value(env_var_name, default)
    ENV[env_var_name] ? ENV[env_var_name] : default
end

def determine_compiler
    if ENV["ANYOLITE_COMPILER"]
        puts "Got compiler from environment variable: #{ENV["ANYOLITE_COMPILER"]}"
        return ENV["ANYOLITE_COMPILER"].downcase.to_sym
    elsif ENV["VisualStudioVersion"] || ENV["VSINSTALLDIR"]
        return :msvc
    else
        return :gcc
    end
end

def install_helper
  use_sfml = $shipectral_config.get_option_value(:use_sfml)
  use_sdl = $shipectral_config.get_option_value(:use_sdl)
  use_rl = $shipectral_config.get_option_value(:use_rl)
  build_path_name = $shipectral_config.get_option_value(:build_path_name)
  frontend = $shipectral_config.get_option_value(:frontend)
  compile_frontend = $shipectral_config.get_option_value(:compile_frontend)
  engine_library = $shipectral_config.get_option_value(:engine_library)
  compile_engine_library = $shipectral_config.get_option_value(:compile_engine_library)
  copy_frontend_assets_to_build_directory = $shipectral_config.get_option_value(:copy_frontend_assets_to_build_directory)
  frontend_asset_directory = $shipectral_config.get_option_value(:frontend_asset_directory)
  add_demos = $shipectral_config.get_option_value(:add_demos)
  add_project_directory = $shipectral_config.get_option_value(:add_project_directory)

  if use_sfml
    if SHIPECTRAL_COMPILER == :msvc
      FileUtils.cp_r "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sfml/bin/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin", :verbose => true
    else
      FileUtils.cp "#{Dir.pwd}/lib/imgui-sfml/libcimgui.so", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/libcimgui.so", :verbose => true
    end
  end

  if use_sdl
    if SHIPECTRAL_COMPILER == :msvc
      FileUtils.cp Dir.glob("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2-2.0.20/lib/x64/*.dll"), "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin", :verbose => true
      FileUtils.cp Dir.glob("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2_mixer-2.0.4/lib/x64/*.dll"), "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin", :verbose => true
      FileUtils.cp Dir.glob("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/sdllib/SDL2_image-2.0.5/lib/x64/*.dll"), "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin", :verbose => true
    else
      # TODO?
    end
  end

  if use_rl
    if SHIPECTRAL_COMPILER == :msvc
      FileUtils.cp Dir.glob("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/raylib-cr/rsrc/native/windows/raylib/lib/*.dll"), "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin", :verbose => true
    else
      # TODO
    end
  end

  if !compile_frontend
    FileUtils.cp_r "#{Dir.pwd}/#{frontend}/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin", :verbose => true
  end

  if !compile_engine_library
    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/#{engine_library}")
    FileUtils.cp_r "#{Dir.pwd}/#{engine_library}/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/#{engine_library}", :verbose => true
  end

  if copy_frontend_assets_to_build_directory
    FileUtils.cp_r "#{Dir.pwd}/#{frontend}/#{frontend_asset_directory}/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/#{frontend_asset_directory}", :verbose => true
  end

  if add_demos
    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/demo_projects")
    FileUtils.cp_r "#{Dir.pwd}/demo_projects/.", "#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/demo_projects"
  end

  if add_project_directory
    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/#{build_path_name}/bin/projects")
  end
end

class ShipectralConfig
  def initialize
    @options = {
      :executable_name => :required,
      :build_path_name => :required,
      :anyolite_config_file => :required,
      :use_sfml => :required,
      :use_sdl => :required,
      :use_rl => :required,
      :use_imgui => :required, # TODO: Make these useful
      :use_collishi => :required, # TODO: Make these useful
      :frontend => :required,
      :frontend_project => :required,
      :compile_frontend => :required,
      :frontend_asset_directory => :required,
      :copy_frontend_assets_to_build_directory => :required,
      :engine_library => :required,
      :engine_library_crystal => :required,
      :engine_library_project => :required,
      :compile_engine_library => :required,
      :add_demos => :required,
      :add_project_directory => :required,
      :debug => :required
    }
  end

  def load_file(filename)
    if File.exist?(filename)
      File.open(filename, "r") do |f|
        content = JSON.load(f)
        content.each do |option, value|
          opt_sym = option.to_sym

          if @options.has_key?(opt_sym)
            @options[opt_sym] = value
          else
            puts "Unknown option: #{opt_sym} with value #{value}."
          end
        end
      end

      @options.each do |option, value|
        if value == :required
          raise "Option #{option} not specified, but required."
        end
      end
    else
      raise "Could not find Shipectral config file #{filename}."
    end
  end

  def get_option_value(name)
    @options[name.to_sym]
  end

  def get_shipectral_compile_script_name
    use_sfml = $shipectral_config.get_option_value(:use_sfml)
    use_sdl = $shipectral_config.get_option_value(:use_sdl)
    use_rl = $shipectral_config.get_option_value(:use_rl)
    
    if (use_sfml && use_sdl) || (use_sfml && use_rl) || (use_sdl && use_rl)
      raise "Using more than one media library in parallel is not supported."
    elsif use_sdl
      "compile_Shipectral_SDL"
    elsif use_sfml
      "compile_Shipectral_SFML"
    elsif use_rl
      "compile_Shipectral_RL"
    else
      "compile_Shipectral_raw"
    end
  end
end