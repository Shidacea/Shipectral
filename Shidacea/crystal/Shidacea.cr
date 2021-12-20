require "./map/Tile.cr"
require "./map/Tileset.cr"
require "./map/MapLayer.cr"

require "./internal/CollisionShape.cr"
require "./internal/Mouse.cr"

require "./graphics/Shape.cr"
require "./graphics/Window.cr"

def load_engine_library(rb)
  setup_ruby_tile_class(rb)
  setup_ruby_tileset_class(rb)
  setup_ruby_map_layer_class(rb)

  setup_ruby_collision_shape_class(rb)

  setup_ruby_window_class(rb)
end
