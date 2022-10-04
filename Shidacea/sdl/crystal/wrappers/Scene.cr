module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Scene
    property use_own_draw_implementation = false
    getter in_ruby = false

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
    
    def initialize
    end

    def rb_initialize(rb)
      @in_ruby = true
    end

    def init
      call_method(:at_init)
    end

    def main_update
      call_method(:update)
    end

    def main_draw
      if @use_own_draw_implementation
        call_inner_draw_block
      else
        SDC.current_window.clear
        call_inner_draw_block
        SDC.current_window.render_and_display
      end
    end

    def call_inner_draw_block
      call_method(:draw)
    end

    def process_events
      SDC.poll_events do |event|
        call_method(:handle_event, event)
      end
    end

    def at_init
    end

    def at_exit
    end

    def update
    end

    def draw
    end

    def handle_event(event : LibSDL::Event)
		end
  end
end