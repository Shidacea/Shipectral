require "anyolite"

require "./ScriptHelper.cr"

require "../engine/Engine.cr"

# MrbRefTable.logging = true

MrbState.create do |mrb|
  module_sdc = MrbModule.new(mrb, "SDC")

  load_wrappers(mrb, module_sdc)

  mrb.load_script_from_file("test/Test.rb")
  MrbInternal.mrb_print_error(mrb)
end

# puts MrbRefTable.inspect
