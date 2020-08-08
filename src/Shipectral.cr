require "anyolite"
require "./SPTLib.cr"

require "./mruby_bindings/Window.cr"

MrbState.create do |mrb|
    setup_ruby_window_class(mrb)
	mrb.execute_script_line("puts 21233")
end

puts "FIN"

mode = SF::VideoMode.new(800, 600)
SPT.window = SF::RenderWindow.new(mode, "Shipectral")
SPT.window.vertical_sync_enabled = true

limiter = SPT::Limiter.new

limiter.set_draw_routine do
	SPT.window.clear()
    SPT.window.display()
end

limiter.set_update_routine do
    while event = SPT.window.poll_event()
        case event
        when SF::Event::Closed
            SPT.window.close()
        else
        end
    end
end

while SPT.window.open?()
	limiter.tick() 
end

SPT.window.close()
