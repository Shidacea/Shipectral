SPT::Features.ensure("sdl")
SPT::Features.ensure("sdl-image")
SPT::Features.ensure("sdl-mixer")
SPT::Features.ensure("sdl-ttf")

require "./wrappers/Main.cr"
require "./wrappers/Window.cr"

def load_engine_library(rb)
  Anyolite.wrap(rb, SDC, verbose: true)
end