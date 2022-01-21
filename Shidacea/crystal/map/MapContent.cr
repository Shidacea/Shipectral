module SDC
  class MapContent
    property width : UInt64 = 0
    property height : UInt64 = 0
    
    property tiles : Array(Array(UInt64)) = [] of Array(UInt64)

    def initialize
    end

    def has_content?
      @tiles.size > 0
    end

    def load_from_array(values : Array(Array(UInt64)))
      @width = values.size.to_u64
      @height = values[0].size.to_u64

      @tiles = [] of Array(UInt64)

      0.upto(@width - 1) do |x|
        @tiles.push([] of UInt64)

        0.upto(@height - 1) do |y|
          @tiles[x].push(values[x][y])
        end
      end
    end
  end
end

def setup_ruby_map_content_class(rb)
  Anyolite.wrap(rb, SDC::MapContent, under: SDC, verbose: true)
end