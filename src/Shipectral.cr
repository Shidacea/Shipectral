SHIPECTRAL_VERSION = "0.2.1"

macro main_routine_with_config(filename)
  {% config_use_sfml = run("./GetConfigOption.cr", filename, "use_sfml").chomp %}
  {% config_frontend = run("./GetConfigOption.cr", filename, "frontend").chomp %}
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

  # TODO: Put these into separate methods for checking

  {% if config_frontend.starts_with?("S|") %}
    {% frontend = config_frontend[2..-1] %}
  {% else %}
    {% raise "Option \"frontend\" is not a string" %}
  {% end %}

  {% if config_engine_library.starts_with?("S|") %}
    {% engine_library = config_engine_library[2..-1] %}
  {% else %}
    {% raise "Option \"engine_library\" is not a string" %}
  {% end %}

  require "anyolite"

  require "./ScriptHelper.cr"
  require "./CrystalCollishi/Collisions.cr"

  {% if use_sfml %}
    require "../engine/EngineSFML.cr"
    require "../engine/EngineImGui.cr"
  {% else %}
    module SF
    end
  {% end %}

  Collishi.test_all_collision_routines

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

      ScriptHelper.load_absolute_path("{{engine_library}}/include")
      ScriptHelper.load_absolute_path("{{engine_library}}/core")
      
      {% if use_sfml %}
        ScriptHelper.load_absolute_file("src/CompatibilityLayer.rb")
      {% end %}

      # TODO: Respect project.json here instead of just calling these scripts

      ScriptHelper.load_absolute_file("{{frontend}}/scripts/Launshi.rb")
      ScriptHelper.load_absolute_file("{{frontend}}/scripts/SceneLaunshi.rb")

      ScriptHelper.path = "{{frontend}}"
      ScriptHelper.load_absolute_file("{{frontend}}/scripts/Main.rb")
      
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