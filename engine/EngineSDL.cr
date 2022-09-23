require "sdl-crystal-bindings"
require "sdl-crystal-bindings/sdl-mixer-bindings"
require "sdl-crystal-bindings/sdl-image-bindings"
require "sdl-crystal-bindings/sdl-ttf-bindings"

SPT::Features.add("sdl")
SPT::Features.add("sdl-mixer")
SPT::Features.add("sdl-image")
SPT::Features.add("sdl-ttf")

def load_sdl_wrappers(rb)
end