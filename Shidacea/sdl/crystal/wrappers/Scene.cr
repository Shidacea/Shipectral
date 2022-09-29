module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Scene
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
      SDC.current_window.clear

      if Anyolite.referenced_in_ruby?(self)
        Anyolite.call_rb_method(:draw)
      else
        draw
      end

      SDC.current_window.render_and_display
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