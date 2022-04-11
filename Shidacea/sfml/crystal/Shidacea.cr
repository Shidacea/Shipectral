SPT::Features.ensure("sfml")

require "./map/Tile.cr"
require "./map/Tileset.cr"
require "./map/Map.cr"
require "./map/MapContent.cr"

require "./internal/CollisionShape.cr"
require "./internal/Mouse.cr"

require "./graphics/Shape.cr"
require "./graphics/Window.cr"

SPT::Features.add("shidacea")

def load_engine_library(rb)
  setup_ruby_tile_class(rb)
  setup_ruby_tileset_class(rb)
  setup_ruby_map_class(rb)
  setup_ruby_map_content_class(rb)

  setup_ruby_collision_shape_class(rb)

  setup_ruby_window_class(rb)
end
