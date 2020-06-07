require "crsfml"

mode = SF::VideoMode.new(800, 600)
window = SF::RenderWindow.new(mode, "Shipectral")
window.vertical_sync_enabled = true

while window.open?
    while event = window.poll_event()
        case event
        when SF::Event::Closed
            window.close()
        else
        end
    end

    window.clear()
    window.display()
end