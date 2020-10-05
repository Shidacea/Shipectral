# TODO: Migrate to RenderQueueWindow from Shidacea

module SF
  class RenderWindow
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
  MrbWrap.wrap_class(mrb, SF::RenderWindow, "RenderWindow", under: module_sdc)
  MrbWrap.wrap_constructor(mrb, SF::RenderWindow, [String, UInt32, UInt32, {Bool, 0}])
  MrbWrap.wrap_instance_method(mrb, SF::RenderWindow, "clear", clear)
  MrbWrap.wrap_instance_method(mrb, SF::RenderWindow, "display", display)
  MrbWrap.wrap_getter(mrb, SF::RenderWindow, "is_open?", open?)
  MrbWrap.wrap_instance_method(mrb, SF::RenderWindow, "close", close)

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
