module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Scene
    property use_own_draw_implementation = false
    
    def initialize
    end

    def init
      if Anyolite.referenced_in_ruby?(self)
        Anyolite.call_rb_method(:at_init)
      else
        at_init
      end
    end

    def main_update
      if Anyolite.referenced_in_ruby?(self)
        Anyolite.call_rb_method(:update)
      else
        update
      end
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
      if Anyolite.referenced_in_ruby?(self)
        Anyolite.call_rb_method(:draw)
      else
        draw
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
  end
end