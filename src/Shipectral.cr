require "./SDCLib.cr"

mode = SF::VideoMode.new(800, 600)
SPT.window = SF::RenderWindow.new(mode, "Shipectral")
SPT.window.vertical_sync_enabled = true

limiter = SPT::Limiter.new

limiter.set_draw_routine do
	SPT.window.clear()
    SPT.window.display()
end

c = 0
limiter.set_update_routine do
    while event = SPT.window.poll_event()
        case event
        when SF::Event::Closed
            SPT.window.close()
        else
        end
    end
    puts c
    c += 1
end

while SPT.window.open?()
	limiter.tick() 
end

SPT.window.close()