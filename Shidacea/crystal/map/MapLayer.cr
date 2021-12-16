module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class MapLayer < SF::Transformable
    include SF::Drawable

    @width : UInt64 = 0
    @height : UInt64 = 0

    @view_width : UInt64 = 0
    @view_height : UInt64 = 0

    @tile_width : UInt64 = 0
    @tile_height : UInt64 = 0

    @background_tile : UInt64 = 0

    @tiles : Array(Array(UInt64)) = [] of Array(UInt64)
    @vertices : SF::VertexArray

    @tileset : Tileset?

    @frame_counter : UInt64 = 0

    property collision_active : Bool = true

    def initialize(@width : UInt64, @height : UInt64, @view_width : UInt64, @view_height : UInt64, @tile_width : UInt64, @tile_height : UInt64)
      super()
      @vertices = SF::VertexArray.new(SF::Quads, @view_width * @view_height * 4)
    end

    def draw(target : SF::RenderTarget, states : SF::RenderStates)
      new_states = states.dup
      if tileset = @tileset
        new_states.transform *= self.transform
        new_states.texture = tileset.texture

        target.draw(@vertices, new_states)
      else
        puts "No tileset!"
      end
    end

    def reload(cam : SF::Vector2f)
      if tileset = @tileset
        exact_shift_x = cam.x - (@view_width - 1) * (@tile_width / 2) - 1
        exact_shift_y = cam.y - (@view_height - 1) * (@tile_height / 2) - 1

        shift_x = exact_shift_x.floor.to_i64 // @tile_width
        shift_y = exact_shift_y.floor.to_i64 // @tile_height

        tileset_size = tileset.texture.size
        n_tiles_x = tileset_size.x // @tile_width
        n_tiles_y = tileset_size.y // @tile_height

        0.upto(@view_width - 1) do |x|
          0.upto(@view_height - 1) do |y|
            exact_actual_x = x.to_f32 + exact_shift_x / @tile_width
            exact_actual_y = y.to_f32 + exact_shift_y / @tile_height

            actual_x = exact_actual_x.floor.to_i64
            actual_y = exact_actual_y.floor.to_i64

            tile_id = (actual_x < 0 || actual_x.to_u64 >= @width || actual_y < 0 || actual_y.to_u64 >= @height) ? @background_tile : @tiles[actual_x][actual_y]

            actual_tile_id = tile_id

            tile_info = tileset.get_tile(tile_id)

            actual_tile_id = tile_info.get_animation_frame(@frame_counter) if tile_info.is_animation_frame?

            tx = actual_tile_id % n_tiles_x
            ty = actual_tile_id // n_tiles_x

            0u64.upto(3) do |c|
              dx = (c == 1 || c == 2) ? 1 : 0
              dy = (c == 2 || c == 3) ? 1 : 0

              vx = ((actual_x + dx.to_i64) * @tile_width.to_i64).to_f32
              vy = ((actual_y + dy.to_i64) * @tile_height.to_i64).to_f32

              vtx = ((tx + dx) * @tile_width.to_i64).to_f32
              vty = ((ty + dy) * @tile_height.to_i64).to_f32

              @vertices[(x.to_u64 * @view_height + y.to_u64) * 4 + c] = SF::Vertex.new({vx, vy}, {vtx, vty})
            end
          end
        end

        @frame_counter &+= 1
      else
        puts "No tileset"
      end
    end

    def load_test_map
      @background_tile = 4
      
      debug_counter = 0u64

      @tiles = [[] of UInt64]

      0.upto(@width - 1) do |ix|
        @tiles.push([] of UInt64)
        0.upto(@height - 1) do |iy|
          @tiles[ix].push(debug_counter % 3 + 2)
          @tiles[ix][iy] = 2 if @tiles[ix][iy] == 4
          debug_counter &*= 7
          debug_counter &+= 3
        end
      end
    end

    def set_tile(x : UInt64, y : UInt64, tile_id : UInt64)
      @tiles[x][y] = tile_id
    end

    def get_tile(x : UInt64, y : UInt64)
      @tiles[x][y]
    end

    def replace_tiles(new_tiles : Array(Array(UInt64)))
      @tiles = new_tiles
    end

    def [](x : UInt64, y : UInt64)
      get_tile(x, y)
    end

    def tileset
      if @tileset
        @tileset
      else
        raise "No tileset"  # TODO
      end
    end

    def link_tileset(tileset : Tileset)
      @tileset = tileset
      tileset.get_tile(4).set_animation(4, 5, 2, 60)  # TODO
    end

    def dup
      new_map_layer = SDC::MapLayer.new(@width, @height, @view_width, @view_height, @tile_width, @tile_height)
      if tileset = @tileset
        new_map_layer.link_tileset(tileset)
      end
      new_map_layer.replace_tiles(@tiles)
      new_map_layer
    end
  end
end

def setup_ruby_map_layer_class(rb)
  Anyolite.wrap(rb, SDC::MapLayer, under: SDC, verbose: true, connect_to_superclass: true)
end