require "anyolite"

require "crsfml"
require "crsfml/audio"

require "./ScriptHelper.cr"

require "../engine/audio/Music.cr"

require "../engine/graphics/Window.cr"
require "../engine/graphics/Text.cr"

MrbState.create do |mrb|
    module_sdc = MrbModule.new(mrb, "SDC")

    setup_ruby_music_class(mrb, module_sdc)
    setup_ruby_window_class(mrb, module_sdc)
    setup_ruby_text_class(mrb, module_sdc)

    mrb.load_script_from_file("test/Test.rb")
    MrbInternal.mrb_print_error(mrb)
end
