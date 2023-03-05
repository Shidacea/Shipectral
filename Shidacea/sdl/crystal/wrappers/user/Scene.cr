module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Scene
    @entity_groups : Hash(String, EntityGroup) = {} of String => EntityGroup

    property use_own_draw_implementation : Bool = false
    property state : SDC::ObjectState = SDC::ObjectState.new

    getter data : SDC::ObjectDataScene
    getter last_event : SDC::Event?

    @hook_handler : SDC::HookHandlerScene = SDC::HookHandlerScene.new

    def initialize(@data : SDC::ObjectDataScene)
      @hook_handler.add_hooks(@data.copy_hooks)
    end

    def update_entity_group(name : String)
      @entity_groups[name].needs_update = true
    end

    def draw_entity_group(name : String)
      @entity_groups[name].needs_draw = true
    end

    def add_entity_group(name : String, group : SDC::EntityGroup)
      @entity_groups[name] = group
    end

    def remove_entity_group(name : String)
      @entity_groups.delete(name)
    end

    def interpreter_test(text : String)
      puts "Current layer: #{Anyolite.get_interpreter_depth} from #{text}"
    end

    def init
      @hook_handler.trigger_hook(self, "init")
    end

    def exit
      @hook_handler.trigger_hook(self, "exit")
    end

    def main_update
      @hook_handler.trigger_hook(self, "update")
      @entity_groups.each do |index, value|
        value.update
      end
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
      @entity_groups.each do |index, value|
        value.draw
      end
    end

    def process_events
      SDC.poll_events do |event|
        @last_event = event.not_nil!
        @hook_handler.trigger_hook(self, "handle_event")
      end
      @last_event = nil
    end
  end
end