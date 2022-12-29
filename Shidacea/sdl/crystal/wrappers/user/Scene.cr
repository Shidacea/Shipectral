module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Scene
    property use_own_draw_implementation : Bool = false
    getter in_ruby : Bool = false

    getter data : SDC::ObjectDataScene

    getter last_event : SDC::Event?

    property state : SDC::ObjectState = SDC::ObjectState.new

    @hook_handler : SDC::HookHandlerScene = SDC::HookHandlerScene.new

    macro call_method(name, *args)
      if @in_ruby
        {% if args.empty? %}
          Anyolite.call_rb_method({{name}})
        {% else %}
          Anyolite.call_rb_method({{name}}, args: [{{*args}}])
        {% end %}
      else
        {{name.id}}({{*args}})
      end
    end
    
    def initialize(@data : SDC::ObjectDataScene)
      @hook_handler.add_hooks(@data.copy_hooks)
    end

    def interpreter_test(text : String)
      puts "Current layer: #{Anyolite.get_interpreter_depth} from #{text}"
    end

    def rb_initialize(rb)
      @in_ruby = true
    end

    def init
      interpreter_test("Call Init")
      @hook_handler.trigger_hook(self, "init")
      call_method(:at_init)
    end

    def exit
      @hook_handler.trigger_hook(self, "exit")
      call_method(:at_exit)
    end

    def main_update
      @hook_handler.trigger_hook(self, "update")
      call_method(:update)
    end

    def main_draw
      if @use_own_draw_implementation
        call_inner_draw_block
      elsif win = SDC.current_window
        win.clear
        call_inner_draw_block
        win.render_and_display
      end
    end

    def call_inner_draw_block
      @hook_handler.trigger_hook(self, "draw")
      call_method(:draw)
    end

    def process_events
      SDC.poll_events do |event|
        @last_event = event.not_nil!
        @hook_handler.trigger_hook(self, "handle_event")
        call_method(:handle_event, event)
      end
      @last_event = nil
    end

    def at_init
    end

    def at_exit
    end

    def update
    end

    def draw
    end

    def handle_event(event : SDC::Event)
		end
  end
end