require "crsfml"
require "crsfml/audio"

require "./audio/Music.cr"
require "./audio/SoundBuffer.cr"
require "./audio/Sound.cr"

require "./graphics/Color.cr"
require "./graphics/Shape.cr"
require "./graphics/Font.cr"
require "./graphics/RenderStates.cr"
require "./graphics/Sprite.cr"
require "./graphics/Text.cr"
require "./graphics/Texture.cr"
require "./graphics/View.cr"

require "./internal/Vector.cr"
require "./internal/Rect.cr"
require "./internal/Keyboard.cr"
require "./internal/Mouse.cr"
require "./internal/Event.cr"
require "./internal/CollisionShape.cr"

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
  setup_ruby_collision_shape_class(rb)

  setup_ruby_tile_class(rb)
  setup_ruby_tileset_class(rb)
  setup_ruby_map_layer_class(rb)

  setup_ruby_imgui_module(rb)
end
