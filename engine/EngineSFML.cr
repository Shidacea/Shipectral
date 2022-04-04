require "crsfml"
require "crsfml/audio"
require "crsfml/network"

require "./sfml/audio/Music.cr"
require "./sfml/audio/SoundBuffer.cr"
require "./sfml/audio/Sound.cr"

require "./sfml/graphics/Color.cr"
require "./sfml/graphics/Shape.cr"
require "./sfml/graphics/Font.cr"
require "./sfml/graphics/RenderStates.cr"
require "./sfml/graphics/Sprite.cr"
require "./sfml/graphics/Text.cr"
require "./sfml/graphics/Texture.cr"
require "./sfml/graphics/View.cr"

require "./sfml/internal/Vector.cr"
require "./sfml/internal/Rect.cr"
require "./sfml/internal/Keyboard.cr"
require "./sfml/internal/Mouse.cr"
require "./sfml/internal/Event.cr"

require "./sfml/networking/Socket.cr"

def load_sfml_wrappers(rb)
  setup_ruby_music_class(rb)
  setup_ruby_sound_buffer_class(rb)
  setup_ruby_sound_class(rb)

  setup_ruby_color_class(rb)
  setup_ruby_draw_shape_class(rb)
  setup_ruby_font_class(rb)
  setup_ruby_render_states_class(rb)
  setup_ruby_sprite_class(rb)
  setup_ruby_text_class(rb)
  setup_ruby_texture_class(rb)
  setup_ruby_view_class(rb)

  setup_ruby_vector_class(rb)
  setup_ruby_rect_class(rb)
  setup_ruby_keyboard_class(rb)
  setup_ruby_mouse_class(rb)
  setup_ruby_event_class(rb)

  setup_ruby_socket_class(rb)

  SPT::Features.add("sfml")
end
