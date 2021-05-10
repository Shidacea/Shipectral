require "anyolite"

require "crsfml"
require "crsfml/audio"

require "./ScriptHelper.cr"
require "../engine/Engine.cr"

Anyolite::RbInterpreter.create do |rb|
  Anyolite.wrap_module(rb, SF, "SF")
  load_wrappers(rb)

  rb.load_script_from_file("test/Test.rb")
  Anyolite::RbCore.rb_print_error(rb)
end
