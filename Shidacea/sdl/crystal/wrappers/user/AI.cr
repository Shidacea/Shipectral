module SDC
  module AI
    class RubyScriptTemplate
      @proc : Anyolite::RbRef

      # NOTE: This might be one of the most evil codes I've ever written.
      # What this does: You can write Ruby routines in Crystal.
      # Crystal even checks the code for syntactic validity.
      # Yep.
      # After I wrote this I gave two wisdom teeth as penance.
      macro create(&block)
        %new_proc = Anyolite.eval("Proc.new #{{{block.stringify}}}")
        SDC::AI::RubyScriptTemplate.new(%new_proc)
      end

      @[Anyolite::Specialize]
      @[Anyolite::StoreBlockArg]
      def self.create
        new_proc = Anyolite.obtain_given_rb_block

        if !new_proc
          SDC.error "Created Ruby script template without block"
        end

        self.new(new_proc.not_nil!)
      end

      def initialize(@proc : Anyolite::RbRef)
      end

      def generate_fiber
        ai_helper_class = Anyolite.eval("SDC::AI::Helper")
        Anyolite.call_rb_method_of_object(ai_helper_class, :create_fiber_from_proc, [@proc])
      end
    end

    # TODO: Add multiple pages
    class RubyScript
      @ruby_fiber : Anyolite::RbRef

      def initialize(template : SDC::AI::RubyScriptTemplate)
        @ruby_fiber = template.generate_fiber
      end

      def tick(entity : SDC::Entity)
        rb = Anyolite::RbRefTable.get_current_interpreter
        arg = Anyolite::RbCast.return_value(rb.to_unsafe, entity)
        Anyolite::RbCore.rb_fiber_resume(rb, @ruby_fiber.to_unsafe, 1, pointerof(arg)) if running?
        nil
      end

      def running?
        Anyolite.call_rb_method_of_object(@ruby_fiber.to_unsafe, :"alive?", cast_to: Bool)
      end
    end
  end
end