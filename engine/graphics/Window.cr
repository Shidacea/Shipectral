# TODO: Migrate to RenderQueueWindow from Shidacea

module SF
  @[Anyolite::RenameClass("Window")]
  @[Anyolite::ExcludeInstanceMethod("create")]
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::ExcludeInstanceMethod("draw")]
  @[Anyolite::SpecializeInstanceMethod("position=", [position : Vector2 | Tuple], [position : Vector2i])]
  @[Anyolite::SpecializeInstanceMethod("size=", [size : Vector2 | Tuple], [size : Vector2i])]
  @[Anyolite::SpecializeInstanceMethod("map_pixel_to_coords", [point : Vector2 | Tuple, view : View], [point : Vector2i, view : View])]
  @[Anyolite::SpecializeInstanceMethod("map_coords_to_pixel", [point : Vector2 | Tuple, view : View], [point : Vector2f, view : View])]
  @[Anyolite::SpecializeInstanceMethod("clear", [color : Color = Color.new(0, 0, 0, 255)], [color : Color = SF::Color.new(0, 0, 0, 255)])]
  class RenderWindow
    @[Anyolite::Rename("draw")]
    def pseudo_draw(drawable : Sprite, states : RenderStates = SF::RenderStates.new)
      drawable.draw(target: self, states: states)
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
  end
end

def setup_ruby_window_class(rb)
  Anyolite.wrap(rb, SF::RenderWindow, under: SF, verbose: true, wrap_superclass: false)
end
