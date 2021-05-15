require "anyolite"

require "crsfml"
require "crsfml/audio"

require "./ScriptHelper.cr"
require "../engine/Engine.cr"

Anyolite::RbInterpreter.create do |rb|
  Anyolite.wrap_module(rb, SF, "SDC")
  load_wrappers(rb)

  ScriptHelper.load_absolute_path("shidacea/include")
  ScriptHelper.load_absolute_path("shidacea/core")

  ScriptHelper.load("Test.rb")
  
  Anyolite::RbCore.rb_print_error(rb)
end
