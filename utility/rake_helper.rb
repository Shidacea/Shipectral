require 'fileutils'
require 'json'

def get_value(env_var_name, default)
    ENV[env_var_name] ? ENV[env_var_name] : default
end

def determine_compiler
    if ENV["ANYOLITE_COMPILER"]
        puts "Got compiler from environment variable: #{ANYOLITE_COMPILER}"
        return ENV["ANYOLITE_COMPILER"].downcase.to_sym
    elsif ENV["VisualStudioVersion"] || ENV["VSINSTALLDIR"]
        return :msvc
    else
        return :gcc
    end
end

class ShipectralConfig
  def initialize
    @options = {
      :executable_name => :required,
      :build_path_name => :required,
      :anyolite_config_file => :required,
      :use_sfml => :required,
      :use_imgui => :required, # TODO: Make these useful
      :use_collishi => :required, # TODO: Make these useful
      :frontend => :required,
      :frontend_project => :required,
      :compile_frontend => :required,
      :frontend_asset_directory => :required,
      :copy_frontend_assets_to_build_directory => :required,
      :engine_library => :required,
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
end