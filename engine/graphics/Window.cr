# TODO: Migrate to RenderQueueWindow from Shidacea

module SF
  @[Anyolite::RenameClass("Window")]
  @[Anyolite::ExcludeInstanceMethod("create")]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : Vector2i])]
  @[Anyolite::SpecializeInstanceMethod("size=", [size : Vector2 | Tuple], [size : Vector2i])]
  @[Anyolite::SpecializeInstanceMethod("map_pixel_to_coords", [point : Vector2 | Tuple, view : View], [point : Vector2i, view : View])]
  @[Anyolite::SpecializeInstanceMethod("map_coords_to_pixel", [point : Vector2 | Tuple, view : View], [point : Vector2f, view : View])]
  @[Anyolite::SpecializeInstanceMethod("clear", [color : Color = Color.new(0, 0, 0, 255)], [color : Color = SF::Color.new(0, 0, 0, 255)])]
  class RenderWindow
    @[Anyolite::Rename("draw")]
    def pseudo_draw(drawable : Sprite | Text | Shape | Transformable, states : RenderStates = SF::RenderStates.new)
      drawable.as(Drawable).draw(target: self, states: states)
    end

    @[Anyolite::Specialize]
    @[Anyolite::WrapWithoutKeywords(3)]
    def initialize(title : String, width : UInt32, height : UInt32, fullscreen : Bool = false)
      if fullscreen
        initialize(mode: SF::VideoMode.new(width, height), title: title, style: SF::Style::Fullscreen)
      else
        initialize(mode: SF::VideoMode.new(width, height), title: title)
      end
    end

    def is_open?
      open?
    end

    def has_focus?
      focus?
    end

    @[Anyolite::WrapWithoutKeywords]
    def use_view(view : View)
      self.view = view
    end

    @[Anyolite::WrapWithoutKeywords]
    def draw_translated(draw_object : Sprite | Text | Shape | Transformable, z : Float32, coords : Vector2f, render_states : SF::RenderStates | Nil = nil)
      actual_render_states = render_states ? render_states : SF::RenderStates.new

      transform = Transform.new
      transform.translate(coords)
      actual_render_states.transform *= transform

      draw_object.as(Drawable).draw(target: self, states: actual_render_states)
    end

    @[Anyolite::WrapWithoutKeywords]
    def set_view(view : View)
      self.view = view
    end

    # TODO: Wrap this into a RenderQueue and add z-drawing and stuff

    def render_and_display
      display
    end

    # TODO: Add ImGUI

    def imgui_defined?
      false
    end
  end
end

def setup_ruby_window_class(rb)
  Anyolite.wrap_class(rb, SF::Window, "BaseWindow", under: SF)
  Anyolite.wrap(rb, SF::RenderWindow, under: SF, verbose: true, connect_to_superclass: true)
end
