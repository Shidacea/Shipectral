module SDC
  module AI
    class RubyScriptTemplatePage
      @proc : Anyolite::RbRef

      # NOTE: This might be one of the most evil codes I've ever written.
      # What this does: You can write Ruby routines in Crystal.
      # Crystal even checks the code for syntactic validity.
      # Yep.
      # After I wrote this I gave two wisdom teeth as penance.
      macro create(&block)
        %new_proc = Anyolite.eval("Proc.new #{{{block.stringify}}}")
        SDC::AI::RubyScriptTemplatePage.new(%new_proc)
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
    @[Anyolite::SpecifyGenericTypes([T])]
    class RubyScript(T)
      @ruby_fiber : Anyolite::RbRef

      def initialize(template : SDC::AI::RubyScriptTemplatePage)
        @ruby_fiber = template.generate_fiber
      end

      def tick(obj : T)
        raise "Too deep: #{Anyolite.get_interpreter_depth}" if Anyolite.get_interpreter_depth >= 1
        rb = Anyolite::RbRefTable.get_current_interpreter
        arg = Anyolite::RbCast.return_value(rb.to_unsafe, obj)
        # TODO: Integrate this functionality into Anyolite
        idx = Anyolite::RbCore.rb_gc_arena_save(rb)
        Anyolite::RbCore.rb_fiber_resume(rb, @ruby_fiber.to_unsafe, 1, pointerof(arg)) if running?
        err = Anyolite::RbCore.get_last_rb_error(rb)
        converted_err = Anyolite.call_rb_method_of_object(err, "to_s", cast_to: String)
        raise "Error at ticking #{T}: #{converted_err}" if converted_err != ""
        Anyolite::RbCore.rb_gc_arena_restore(rb, idx)
        running?
      end

      def running?
        Anyolite.call_rb_method_of_object(@ruby_fiber.to_unsafe, :"alive?", cast_to: Bool)
      end
    end

    alias RubyScriptEntity = RubyScript(SDC::Entity)
    alias RubyScriptScene = RubyScript(SDC::Scene)
  end
end
