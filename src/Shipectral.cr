require "anyolite"

require "crsfml"
require "crsfml/audio"

require "./ScriptHelper.cr"
require "../engine/Engine.cr"

Anyolite::RbInterpreter.create do |rb|
  Anyolite.wrap_module(rb, SF, "SDC")
  load_wrappers(rb)

  Anyolite.wrap(rb, ScriptHelper, under: SF, verbose: true, wrap_superclass: false)

  ScriptHelper.load_absolute_file("src/SDCExtensions.rb")

  ScriptHelper.load_absolute_path("third_party/Shidacea/include")
  ScriptHelper.load_absolute_path("third_party/Shidacea/core")
  
  ScriptHelper.load_absolute_file("src/CompatibilityLayer.rb")

  ScriptHelper.load_absolute_file("third_party/Launshi/scripts/Launshi.rb")
  ScriptHelper.load_absolute_file("third_party/Launshi/scripts/SceneLaunshi.rb")

  ScriptHelper.path = "third_party/Launshi"
  ScriptHelper.load_absolute_file("third_party/Launshi/scripts/Main.rb")

  ScriptHelper.path = "test"
  ScriptHelper.load("Test.rb")
  
  Anyolite::RbCore.rb_print_error(rb)
end
