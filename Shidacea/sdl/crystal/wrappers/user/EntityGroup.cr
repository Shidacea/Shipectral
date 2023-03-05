module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class EntityGroup
    @content : Array(SDC::Entity) = [] of SDC::Entity
    property needs_update : Bool = false
    property needs_draw : Bool = false
    
    def initialize
    end

    def add(value : SDC::Entity)
      @content.push value
      @content.size - 1
    end

    def update
      return if !@needs_update
      @content.each do |entity|
        entity.update
      end
      @needs_update = false
    end

    def draw
      return if !@needs_draw
      @content.each do |entity|
        entity.draw
      end
      @needs_draw = false
    end

    def clear
      @content.clear
    end
  end
end