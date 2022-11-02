@[Anyolite::ExcludeConstant("AI")]
module SDC
  module AI
    class RubyScript
      @ruby_fiber : Anyolite::RbRef

      # NOTE: This might be one of the most evil codes I've ever written.
      # What this does: You can write Ruby routines in Crystal.
      # Crystal even checks the code for syntactic validity.
      # Yep.
      # Time to offer some of my blood and bones to the elder goat lords in exchange.
      macro create(&block)
        SDC::AI::RubyScript.new({{block.stringify}}, with_do_end: false)
      end
      
      def initialize(content : String, with_do_end : Bool = true)
        if with_do_end
          # TODO: Can this be generalized?
          @ruby_fiber = Anyolite.eval("Fiber.new do |entity|\n#{content}\nend")
        else
          @ruby_fiber = Anyolite.eval("Fiber.new #{content}")
        end
      end

      def tick(entity : SDC::Entity)
        Anyolite.call_rb_method_of_object(@ruby_fiber.to_unsafe, :resume, [entity]) if running?
      end

      def running?
        Anyolite.call_rb_method_of_object(@ruby_fiber.to_unsafe, :"alive?", cast_to: Bool)
      end
    end
  end
end