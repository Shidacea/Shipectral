module SPT
  class MapConfig
    getter map_name
    property tileset_index : SPT::IndexType | Nil

    @map_name : String
    @script : Proc(Nil) = ->{}

    def initialize(map_name)
      @map_name = map_name
      @script = ->{}
    end

    # TODO: Could be extended for multiple pages

    def script(&block)
      @script = block
    end

    def run_script
      @script.call
    end
  end
end
