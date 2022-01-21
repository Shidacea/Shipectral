module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class MapContent
    property width : UInt64 = 0
    property height : UInt64 = 0
    
    property tiles : Array(Array(UInt64)) = [] of Array(UInt64)

    def initialize
    end

    def has_content?
      @tiles.size > 0
    end

    def set_size(width : UInt64, height : UInt64)
      @width = width
      @height = height
    end

    def add_line_from_array(values : Array(UInt64))
      @tiles.push([] of UInt64)

      0.upto(@width - 1) do |x|
        @tiles[-1].push(values[x])
      end 
    end

    def load_from_array(values : Array(Array(UInt64)))
      @height = values.size.to_u64
      @width = values[0].size.to_u64

      @tiles = [] of Array(UInt64)

      0.upto(@height - 1) do |y|
        @tiles.push([] of UInt64)

        0.upto(@width - 1) do |x|
          @tiles[y].push(values[y][x])
        end
      end
    end
  end
end

def setup_ruby_map_content_class(rb)
  Anyolite.wrap(rb, SDC::MapContent, under: SDC, verbose: true)
end