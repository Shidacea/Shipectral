# TODO: Migrate to RenderQueueWindow from Shidacea

module SF
  @[MrbWrap::ExcludeInstanceMethod(:draw)]
  @[MrbWrap::ExcludeInstanceMethod(:create)]
  @[MrbWrap::ExcludeInstanceMethod(:map_coords_to_pixel)]
  @[MrbWrap::ExcludeInstanceMethod(:map_pixel_to_coords)]
  @[MrbWrap::ExcludeInstanceMethod(:set_icon)]
  @[MrbWrap::ExcludeInstanceMethod("position=")]
  @[MrbWrap::ExcludeInstanceMethod("size=")]
  @[MrbWrap::SpecializeInstanceMethod(:clear, [color : Color = Color.new(0, 0, 0, 255)], [color : SF::Color = SF::Color.new(0, 0, 0, 255)])]
  class RenderWindow
    
    @[MrbWrap::Specialize]
    def initialize(title : String, width : UInt32, height : UInt32, fullscreen : Bool = false)
      if fullscreen
        initialize(mode: SF::VideoMode.new(width, height), title: title, style: SF::Style::Fullscreen)
      else
        initialize(mode: SF::VideoMode.new(width, height), title: title)
      end
    end
  end
end

def setup_ruby_window_class(mrb, module_sdc)
  MrbWrap.wrap(mrb, SF::RenderWindow, under: SF, verbose: true)
  #MrbWrap.wrap_constructor(mrb, SF::RenderWindow, [String, UInt32, UInt32, {Bool, 0}])
  #MrbWrap.wrap_instance_method(mrb, SF::RenderWindow, "clear", clear)
  #MrbWrap.wrap_instance_method(mrb, SF::RenderWindow, "display", display)
  #MrbWrap.wrap_getter(mrb, SF::RenderWindow, "is_open?", open?)
  #MrbWrap.wrap_instance_method(mrb, SF::RenderWindow, "close", close)

  # TODO: Wait until Anyolite supports functions of this kind
  mrb.define_method("poll_event", MrbClassCache.get(SF::RenderWindow), 
    MrbFunc.new do |mrb, obj|
      converted_obj = MrbMacro.convert_from_ruby_object(mrb, obj, SF::RenderWindow).value
      polled_event = converted_obj.poll_event
      if polled_event
        MrbCast.return_value(mrb, polled_event)
      else 
        MrbCast.return_nil
      end
    end
  )

end
