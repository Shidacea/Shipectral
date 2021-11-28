require 'fileutils'
require 'json'

def get_value(env_var_name, default)
    ENV[env_var_name] ? ENV[env_var_name] : default
end

def determine_compiler
    if ENV["ANYOLITE_COMPILER"]
        return ENV["ANYOLITE_COMPILER"].lowercase.to_sym
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
      :anyolite_config_file => :required,
      :use_sfml => :required,
      :use_imgui => :required, # TODO
      :use_collishi => :required, # TODO
      :frontend => :required,
      :frontend_project => :required,
      :compile_frontend => :required,
      :engine_library => :required,
      :engine_library_project => :required,
      :compile_engine_library => :required,
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