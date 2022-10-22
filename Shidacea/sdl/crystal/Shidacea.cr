SPT::Features.ensure("sdl")
SPT::Features.ensure("sdl-image")
SPT::Features.ensure("sdl-mixer")
SPT::Features.ensure("sdl-ttf")

require "./wrappers/Helper.cr"

require "./wrappers/Main.cr"

require "./wrappers/Coords.cr"
require "./wrappers/Drawable.cr"
require "./wrappers/Event.cr"
require "./wrappers/Keyboard.cr"
require "./wrappers/Limiter.cr"
require "./wrappers/Mouse.cr"
require "./wrappers/Music.cr"
require "./wrappers/Rect.cr"
require "./wrappers/Renderer.cr"
require "./wrappers/RenderQueue.cr"
require "./wrappers/Scene.cr"
require "./wrappers/Sound.cr"
require "./wrappers/Sprite.cr"
require "./wrappers/Texture.cr"
require "./wrappers/Window.cr"

def load_engine_library(rb)
  Anyolite.wrap(rb, SDC, verbose: true)
end
