require "anyolite"

require "./ScriptHelper.cr"

require "../engine/Engine.cr"

MrbState.create do |mrb|
  module_sdc = MrbWrap.wrap_module(mrb, SF, "SF")

  load_wrappers(mrb, module_sdc)

  mrb.load_script_from_file("test/Test.rb")
  MrbInternal.mrb_print_error(mrb)
end

#puts MrbRefTable.inspect
