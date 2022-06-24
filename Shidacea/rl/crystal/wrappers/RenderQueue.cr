module SDC
  abstract class Drawable
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class RenderQueue
    @content : Deque(Drawable) = Deque(Drawable).new

    def initialize
    end

    @[Anyolite::ReturnNil]
    def add(obj : Drawable)
      @content.push(obj)
    end

    @[Anyolite::ReturnNil]
    def draw
      @content.reject! do |element|
        element.draw
        true
      end
    end
  end
end