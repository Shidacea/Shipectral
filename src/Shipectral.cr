SHIPECTRAL_VERSION = "0.2.1"

require "./CompilationHelper.cr"
require "anyolite"
require "./ScriptHelper.cr"

macro load_compiled_frontend_project(frontend_scripts)
  {% c = 0 %}
  {% for script in frontend_scripts %}
    {% if script.ends_with? ".rb" %}
      Anyolite::Preloader::AtCompiletime.load_bytecode_array_from_file({{script}})

      rb = Anyolite::RbRefTable.get_current_interpreter
      Anyolite::Preloader.execute_bytecode_from_cache_or_file(rb, {{script}})
    {% else %}
      {% raise "Not a ruby script file: #{script}" %}
    {% end %}
    {% c += 1 %}
  {% end %}
end

macro main_routine_with_config(filename)
  {% config_use_sfml = run("./GetConfigOption.cr", filename, "use_sfml").chomp %}
  {% config_use_collishi = run("./GetConfigOption.cr", filename, "use_collishi").chomp %}
  {% config_frontend = run("./GetConfigOption.cr", filename, "frontend").chomp %}
  {% config_compile_frontend = run("./GetConfigOption.cr", filename, "compile_frontend").chomp %}
  {% config_frontend_project = run("./GetConfigOption.cr", filename, "frontend_project").chomp %}
  {% config_engine_library = run("./GetConfigOption.cr", filename, "engine_library").chomp %}

  {% if config_use_sfml.starts_with?("B|") %}
    {% if config_use_sfml[2..-1] == "true" %}
      {% use_sfml = true %}
    {% else %}
      {% use_sfml = false %}
    {% end %}
  {% else %}
    {% raise "Option \"use_sfml\" is not a bool" %}
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

  {% if config_compile_frontend.starts_with?("B|") %}
    {% if config_compile_frontend[2..-1] == "true" %}
      {% compile_frontend = true %}
    {% else %}
      {% compile_frontend = false %}
    {% end %}
  {% else %}
    {% raise "Option \"compile_frontend\" is not a bool" %}
  {% end %}

  {% if config_frontend_project.starts_with?("S|") %}
    {% frontend_project = config_frontend_project[2..-1] %}
  {% else %}
    {% raise "Option \"frontend_project\" is not a string" %}
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

  {% if use_collishi %}
    require "./CrystalCollishi/Collisions.cr"
  {% end %}

  {% if use_sfml %}
    require "../engine/EngineSFML.cr"
    require "../engine/EngineImGui.cr"
  {% else %}
    module SF
    end
  {% end %}

  {% if use_collishi %}
    Collishi.test_all_collision_routines
  {% end %}

  begin
    Anyolite::RbInterpreter.create do |rb|
      Anyolite.wrap_module(rb, SF, "SDC")

      {% if use_sfml %}
        load_sfml_wrappers(rb)
        load_imgui_wrappers(rb)
      {% end %}

      Anyolite.wrap(rb, ScriptHelper, under: SF, verbose: true, connect_to_superclass: false)

      {% if use_sfml %}
        ScriptHelper.load_absolute_file("src/SDCExtensions.rb")
      {% end %}

      {% if engine_library != false %}
        ScriptHelper.load_absolute_path("{{engine_library}}/include")
        ScriptHelper.load_absolute_path("{{engine_library}}/core")
      {% end %}
      
      {% if use_sfml %}
        ScriptHelper.load_absolute_file("src/CompatibilityLayer.rb")
      {% end %}

      {% if compile_frontend %}
        {% if frontend_project.ends_with?(".json") %}
          {% frontend_scripts = run("./GetProjectScripts.cr", frontend, frontend_project) %}
          
          ScriptHelper.path = "{{frontend}}"

          load_compiled_frontend_project({{frontend_scripts}})
        {% else %}
          ScriptHelper.path = "{{frontend}}"
          ScriptHelper.load("{{frontend_project}}")
        {% end %}
      {% else %}
        {% if frontend_project.ends_with?(".json") %}
          scripts = CompilationHelper.get_all_scripts_from_project_file("{{frontend}}", "{{frontend_project}}")

          ScriptHelper.path = "{{frontend}}"

          scripts.each do |script|
            if File.directory?(script)
              ScriptHelper.load_recursively(script)
            else
              ScriptHelper.load(script)
            end
          end
        {% else %}
          ScriptHelper.path = "{{frontend}}"
          ScriptHelper.load("{{frontend_project}}")
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
end

{% if env("SHIPECTRAL_CONFIG_FILE") %}
  main_routine_with_config({{env("SHIPECTRAL_CONFIG_FILE")}})
{% else %}
  main_routine_with_config("configs/launshi.json")
{% end %}