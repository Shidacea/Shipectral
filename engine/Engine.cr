require "crsfml"
require "crsfml/audio"

require "./audio/Music.cr"
require "./audio/SoundBuffer.cr"
require "./audio/Sound.cr"

require "./graphics/Color.cr"
require "./graphics/Font.cr"
require "./graphics/RenderStates.cr"
require "./graphics/Sprite.cr"
require "./graphics/Text.cr"
require "./graphics/Texture.cr"
require "./graphics/Window.cr"

def load_wrappers(mrb, module_sdc)
    setup_ruby_music_class(mrb, module_sdc)
    setup_ruby_sound_buffer_class(mrb, module_sdc)
    setup_ruby_sound_class(mrb, module_sdc)

    setup_ruby_color_class(mrb, module_sdc)
    setup_ruby_font_class(mrb, module_sdc)
    setup_ruby_render_states_class(mrb, module_sdc)
    setup_ruby_sprite_class(mrb, module_sdc)
    setup_ruby_text_class(mrb, module_sdc)
    setup_ruby_texture_class(mrb, module_sdc)
    setup_ruby_window_class(mrb, module_sdc)
end