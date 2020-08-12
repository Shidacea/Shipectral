module SF
    class RenderWindow
        def initialize(title : String)
            initialize(mode: SF::VideoMode.new(800, 600), title: title)
        end
    end
end

def setup_ruby_window_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::RenderWindow, "RenderWindow", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::RenderWindow, [String])
    MrbWrap.wrap_instance_method(mrb, SF::RenderWindow, "close", close)
end