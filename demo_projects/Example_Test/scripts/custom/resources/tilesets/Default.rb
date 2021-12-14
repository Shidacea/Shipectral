tileset = SF::Tileset.new

SDC::Data.load_texture(:TilesetDefault, filename: "assets/graphics/maptest/Tileset.png")

8.times {tileset.add_tile(SDC::CustomTile.new)}
tileset.tiles[3].solid = true
tileset.tiles[4].solid = true
tileset.tiles[5].solid = true

tileset.link_texture(SDC::Data.textures[:TilesetDefault])

SDC::Data.add_tileset(tileset, index: :Default)