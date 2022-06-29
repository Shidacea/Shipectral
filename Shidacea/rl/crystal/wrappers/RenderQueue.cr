module SDC
  abstract class Drawable
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class RenderQueue
    NUMBER_OF_LAYERS = 256
    INITIAL_CAPACITY = 100

    @content : StaticArray(Deque(Drawable), NUMBER_OF_LAYERS) = 
      StaticArray(Deque(Drawable), NUMBER_OF_LAYERS).new do |i|
        capacity = SDC::RenderQueue::INITIAL_CAPACITY
        (Deque(SDC::Drawable).new(initial_capacity: capacity))
      end
    
    @highest_z : UInt8 = 0

    def initialize
    end

    @[Anyolite::ReturnNil]
    def add(obj : Drawable, z : UInt8 = 0u8)
      @content[z].push(obj)
      @highest_z = z if z > @highest_z
    end

    @[Anyolite::ReturnNil]
    def draw
      0.upto(@highest_z) do |z|
        @content[z].reject! do |element|
          element.draw_directly
          true
        end
      end
      @highest_z = 0
    end
  end
end