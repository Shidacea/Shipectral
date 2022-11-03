module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class EntityGroup
    @content : Array(SDC::Entity | Anyolite::RbRef) = [] of SDC::Entity | Anyolite::RbRef
    
    def initialize
    end

    def add(value : SDC::Entity)
      @content.push value
      @content.size - 1
    end

    @[Anyolite::Specialize]
    def add(value : Anyolite::RbRef)
      @content.push value
      @content.size - 1
    end

    def update
      @content.each do |entity|
        if entity.is_a?(SDC::Entity)
          entity.update
        else
          Anyolite.call_rb_method_of_object(entity.to_unsafe, :update)
        end
      end
    end

    def draw
      @content.each do |entity|
        if entity.is_a?(SDC::Entity)
          entity.draw
        else
          Anyolite.call_rb_method_of_object(entity.to_unsafe, :draw)
        end
      end
    end

    def clear
      @content.clear
    end
  end
end