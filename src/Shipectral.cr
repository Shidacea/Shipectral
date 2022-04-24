SHIPECTRAL_VERSION = "0.3.0"

require "./CompilationHelper.cr"
require "anyolite"
require "./Script.cr"

module SPT
  module Features
    @@features : Set(String) = Set(String).new

    def self.add(name : String)
      @@features.add(name)
    end

    def self.check(name : String)
      @@features.includes?(name)
    end

    def self.ensure(name : String, debug_location : String? = nil)
      if self.check(name)
        true
      else
        if debug_location
          raise "Feature '#{name}' required by #{debug_location} was not included."
        else
          raise "Feature '#{name}' was not included."
        end
      end
    end
  end
end

macro load_compiled_script(script)
  {% if script.ends_with? ".rb" %}
    Anyolite::Preloader::AtCompiletime.load_bytecode_array_from_file({{script}})

    rb = Anyolite::RbRefTable.get_current_interpreter
    Anyolite::Preloader.execute_bytecode_from_cache_or_file(rb, {{script}})
  {% else %}
    {% raise "Not a ruby script file: #{script}" %}
  {% end %}
end

macro load_compiled_script_array(scripts_and_features, debug_location)
  {% scripts = scripts_and_features[0] %}
  {% features = scripts_and_features[1] %}

  {% for feature in features %}
    SPT::Features.ensure({{feature}}, {{debug_location}})
  {% end %}

  {% for script in scripts %}
    load_compiled_script({{script}})
  {% end %}
end

macro main_routine_with_config(filename)
  {% config_use_sfml = run("./GetConfigOption.cr", filename, "use_sfml").chomp %}
  {% config_use_sdl = run("./GetConfigOption.cr", filename, "use_sdl").chomp %}
  {% config_use_rl = run("./GetConfigOption.cr", filename, "use_rl").chomp %}
  {% config_use_imgui = run("./GetConfigOption.cr", filename, "use_imgui").chomp %}
  {% config_use_collishi = run("./GetConfigOption.cr", filename, "use_collishi").chomp %}
  {% config_frontend = run("./GetConfigOption.cr", filename, "frontend").chomp %}
  {% config_frontend_project = run("./GetConfigOption.cr", filename, "frontend_project").chomp %}
  {% config_compile_frontend = run("./GetConfigOption.cr", filename, "compile_frontend").chomp %}
  {% config_engine_library = run("./GetConfigOption.cr", filename, "engine_library").chomp %}
  {% config_engine_library_crystal = run("./GetConfigOption.cr", filename, "engine_library_crystal").chomp %}
  {% config_engine_library_project = run("./GetConfigOption.cr", filename, "engine_library_project").chomp %}
  {% config_compile_engine_library = run("./GetConfigOption.cr", filename, "compile_engine_library").chomp %}
  
  {% if config_use_sfml.starts_with?("B|") %}
    {% if config_use_sfml[2..-1] == "true" %}
      {% use_sfml = true %}
    {% else %}
      {% use_sfml = false %}
    {% end %}
  {% else %}
    {% raise "Option \"use_sfml\" is not a bool" %}
  {% end %}

  {% if config_use_sdl.starts_with?("B|") %}
    {% if config_use_sdl[2..-1] == "true" %}
      {% use_sdl = true %}
    {% else %}
      {% use_sdl = false %}
    {% end %}
  {% else %}
    {% raise "Option \"use_sdl\" is not a bool" %}
  {% end %}

  {% if config_use_rl.starts_with?("B|") %}
    {% if config_use_rl[2..-1] == "true" %}
      {% use_rl = true %}
    {% else %}
      {% use_rl = false %}
    {% end %}
  {% else %}
    {% raise "Option \"use_rl\" is not a bool" %}
  {% end %}

  {% if config_use_imgui.starts_with?("B|") %}
    {% if config_use_imgui[2..-1] == "true" %}
      {% use_imgui = true %}
    {% else %}
      {% use_imgui = false %}
    {% end %}
  {% else %}
    {% raise "Option \"use_imgui\" is not a bool" %}
  {% end %}

  {% if config_use_collishi.starts_with?("B|") %}
    {% if config_use_collishi[2..-1] == "true" %}
      {% use_collishi = true %}
    {% else %}
      {% use_collishi = false %}
    {% end %}
  {% else %}
    {% raise "Option \"use_collishi\" is not a bool" %}
  {% end %}

  # TODO: Put these into separate methods for checking

  {% if config_frontend.starts_with?("S|") %}
    {% frontend = config_frontend[2..-1] %}
  {% else %}
    {% raise "Option \"frontend\" is not a string" %}
  {% end %}

  {% if config_frontend_project.starts_with?("S|") %}
    {% frontend_project = config_frontend_project[2..-1] %}
  {% else %}
    {% raise "Option \"frontend_project\" is not a string" %}
  {% end %}

  {% if config_compile_frontend.starts_with?("B|") %}
    {% if config_compile_frontend[2..-1] == "true" %}
      {% compile_frontend = true %}
    {% else %}
      {% compile_frontend = false %}
    {% end %}
  {% else %}
    {% raise "Option \"compile_frontend\" is not a bool" %}
  {% end %}

  {% if config_engine_library.starts_with?("S|") %}
    {% engine_library = config_engine_library[2..-1] %}
  {% elsif config_engine_library.starts_with?("B|") %}
    {% if config_engine_library[2..-1] == "true" %}
      {% raise "Option \"engine_library\" is neither a string nor false" %}
    {% else %}
      {% engine_library = false %}
    {% end %}
  {% else %}
    {% raise "Option \"engine_library\" is neither a string nor false" %}
  {% end %}

  {% if config_engine_library_crystal.starts_with?("S|") %}
    {% engine_library_crystal = config_engine_library_crystal[2..-1] %}
  {% elsif config_engine_library_crystal.starts_with?("B|") %}
    {% if config_engine_library_crystal[2..-1] == "true" %}
      {% raise "Option \"engine_library_crystal\" is neither a string nor false" %}
    {% else %}
      {% engine_library_crystal = false %}
    {% end %}
  {% else %}
    {% raise "Option \"engine_library_crystal\" is neither a string nor false" %}
  {% end %}

  {% if config_engine_library_project.starts_with?("S|") %}
    {% engine_library_project = config_engine_library_project[2..-1] %}
  {% else %}
    {% raise "Option \"engine_library_project\" is not a string" %}
  {% end %}

  {% if config_compile_engine_library.starts_with?("B|") %}
    {% if config_compile_engine_library[2..-1] == "true" %}
      {% compile_engine_library = true %}
    {% else %}
      {% compile_engine_library = false %}
    {% end %}
  {% else %}
    {% raise "Option \"compile_engine_library\" is not a bool" %}
  {% end %}

  {% if use_collishi %}
    require "./CrystalCollishi/Collisions.cr"

    SPT::Features.add("collishi")
  {% end %}

  {% if use_sfml %}
    require "../engine/EngineSFML.cr"
  {% end %}

  {% if use_sdl %}
    require "../engine/EngineSDL.cr"
  {% end %}

  {% if use_rl %}
    require "../engine/EngineRL.cr"
  {% end %}

  {% if use_imgui %}
    require "../engine/EngineImGui.cr"
  {% end %}

  module SDC
  end

  {% if engine_library_crystal %}
    require "../{{engine_library_crystal}}"
  {% end %}

  {% if use_collishi %}
    Collishi.test_all_collision_routines
  {% end %}

  begin
    Anyolite::RbInterpreter.create do |rb|
      Anyolite.wrap_module(rb, SDC, "SDC")

      {% if use_sfml %}
        Anyolite.wrap_module(rb, SF, "SF")  # TODO: Separate this from this file
        load_sfml_wrappers(rb)
      {% end %}

      {% if use_sdl %}
        # Does currently not do anything, but could be used for custom bindings
        Anyolite.wrap_module(rb, SDL, "SDL")
        load_sdl_wrappers(rb)
      {% end %}

      {% if use_rl %}
        load_rl_wrappers(rb)
      {% end %}

      {% if use_imgui %}
        load_imgui_wrappers(rb)
      {% end %}

      Anyolite.wrap(rb, SDC::Script, under: SDC, verbose: true, connect_to_superclass: false)

      {% if engine_library %}
        {% if engine_library_crystal %}
          load_engine_library(rb)
        {% end %}
        
        {% if compile_engine_library %}
          {% if engine_library_project.ends_with?(".json") %}
            {% engine_library_scripts_and_features = run("./GetProjectScripts.cr", engine_library, engine_library_project).chomp %}
            load_compiled_script_array({{engine_library_scripts_and_features}}, "engine library ({{engine_library}} - {{engine_library_project}})")
          {% else %}
            load_compiled_script("{{engine_library}}/{{engine_library_project}}")
          {% end %}
        {% else %}
          {% if engine_library_project.ends_with?(".json") %}
            scripts = CompilationHelper.get_all_scripts_from_project_file("{{engine_library}}", "{{engine_library_project}}")
            features = CompilationHelper.get_all_features_from_project_file("{{engine_library}}", "{{engine_library_project}}")

            features.each do |feature|
              SPT::Features.ensure(feature, "engine library ({{engine_library}} - {{engine_library_project}})")
            end

            scripts.each do |script|
              full_script_path = File.join("{{engine_library}}", script)

              if File.directory?(full_script_path)
                SDC::Script.load_recursively(full_script_path)
              else
                SDC::Script.load(full_script_path)
              end
            end
          {% else %}
            SDC::Script.load("{{engine_library}}/{{engine_library_project}}")
          {% end %}
        {% end %}
      {% end %}
    
      {% if compile_frontend %}
        {% if frontend_project.ends_with?(".json") %}
          {% frontend_scripts_and_features = run("./GetProjectScripts.cr", frontend, frontend_project).chomp %}
          
          load_compiled_script_array({{frontend_scripts_and_features}}, "frontend ({{frontend}} - {{frontend_project}})")
        {% else %}
          load_compiled_script("{{frontend}}/{{frontend_project}}")
        {% end %}
      {% else %}
        {% if frontend_project.ends_with?(".json") %}
          scripts = CompilationHelper.get_all_scripts_from_project_file(SDC::Script.path, "{{frontend_project}}")
          features = CompilationHelper.get_all_features_from_project_file(SDC::Script.path, "{{frontend_project}}")

          features.each do |feature|
            SPT::Features.ensure(feature, "frontend ({{frontend}} - {{frontend_project}})")
          end

          scripts.each do |script|
            if File.directory?(script)
              SDC::Script.load_recursively(script)
            else
              SDC::Script.load(script)
            end
          end
        {% else %}
          SDC::Script.load("{{frontend_project}}")
        {% end %}
      {% end %}

      Anyolite::RbCore.rb_print_error(rb)
    end
  rescue ex 
    puts "An exception occured in Shipectral: #{ex.inspect_with_backtrace}"
  end

  {% if use_sfml %}
    ImGui::SFML.shutdown
  {% end %}

  {% if use_sdl %}
    SDL.quit
  {% end %}
end

test_run = false

ARGV.each do |arg|
  if arg == "--version"
    test_run = true
  end
end

if test_run
  puts SHIPECTRAL_VERSION
  exit
end

{% if env("SHIPECTRAL_CONFIG_FILE") %}
  main_routine_with_config({{env("SHIPECTRAL_CONFIG_FILE")}})
{% else %}
  main_routine_with_config("configs/launshi_sfml.json")
{% end %}