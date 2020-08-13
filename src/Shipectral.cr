require "anyolite"

require "crsfml"
require "crsfml/audio"

require "./ScriptHelper.cr"

require "../engine/audio/Music.cr"
require "../engine/audio/SoundBuffer.cr"
require "../engine/audio/Sound.cr"

require "../engine/graphics/Window.cr"
require "../engine/graphics/Text.cr"

GC.disable
MrbState.create do |mrb|
    module_sdc = MrbModule.new(mrb, "SDC")

    setup_ruby_music_class(mrb, module_sdc)
    setup_ruby_sound_buffer_class(mrb, module_sdc)
    setup_ruby_sound_class(mrb, module_sdc)

    setup_ruby_window_class(mrb, module_sdc)
    setup_ruby_text_class(mrb, module_sdc)

    mrb.load_script_from_file("test/Test.rb")
    MrbInternal.mrb_print_error(mrb)
end
GC.enable