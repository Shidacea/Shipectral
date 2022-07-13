module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class RenderQueue
    NUMBER_OF_LAYERS = 256
    INITIAL_CAPACITY = 100

    @static_content : StaticArray(Deque(Drawable), NUMBER_OF_LAYERS) = 
      StaticArray(Deque(Drawable), NUMBER_OF_LAYERS).new do |i|
        capacity = SDC::RenderQueue::INITIAL_CAPACITY
        (Deque(SDC::Drawable).new(initial_capacity: capacity))
      end

    @content : StaticArray(Deque(Drawable), NUMBER_OF_LAYERS) = 
      StaticArray(Deque(Drawable), NUMBER_OF_LAYERS).new do |i|
        capacity = SDC::RenderQueue::INITIAL_CAPACITY
        (Deque(SDC::Drawable).new(initial_capacity: capacity))
      end
    
    @highest_z : UInt8 = 0
    @highest_static_z : UInt8 = 0

    def initialize
    end

    @[Anyolite::ReturnNil]
    def add(obj : Drawable, z : UInt8 = 0u8)
      @content[z].push(obj)
      @highest_z = z if z > @highest_z
    end

    @[Anyolite::ReturnNil]
    def add_static(obj : Drawable, z : UInt8 = 0u8)
      @static_content[z].push(obj)
      @highest_static_z = z if z > @highest_static_z
    end

    @[Anyolite::ReturnNil]
    def delete_static(obj : Drawable, z : UInt8 = 0u8, all_duplicates : Bool = false)
      if all_duplicates
        @static_content[z].delete(obj)
      elsif result = @static_content[z].index(obj)
        @static_content[z].delete_at(result)
      end
      # TODO: Maybe update @highest_static_z
    end

    @[Anyolite::ReturnNil]
    def delete_static_content
      0.upto(@highest_static_z) do |z|
        @static_content[z].clear
      end
      @highest_static_z = 0
    end

    # Draw contents and clear the queue
    @[Anyolite::ReturnNil]
    def draw
      max_z = {@highest_z, @highest_static_z}.max

      0.upto(max_z) do |z|
        if z <= @highest_static_z
          @static_content[z].each do |element|
            element.draw_directly
          end
        end
        if z <= @highest_z
          @content[z].reject! do |element|
            element.draw_directly
            true
          end
        end
      end
      @highest_z = 0
    end
  end
end