require "crsfml"

require "./CrystalCollishi/Collisions.cr"

puts Collishi.collision_point_line(0.2, 0.2, 0.0, 0.0, 1.0, 1.0)

require "./engine/Tile.cr"

require "./Types.cr"

require "./Attributes.cr"
require "./Constants.cr"
require "./Input.cr"

require "./AI.cr"
require "./BaseGame.cr"
require "./CustomTile.cr"
require "./Limiter.cr"
require "./MapConfig.cr"
require "./Scene.cr"
