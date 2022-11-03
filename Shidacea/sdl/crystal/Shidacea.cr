SPT::Features.ensure("sdl")
SPT::Features.ensure("sdl-image")
SPT::Features.ensure("sdl-mixer")
SPT::Features.ensure("sdl-ttf")

require "./wrappers/basic/Helper.cr"
require "./wrappers/basic/Main.cr"

require "./wrappers/audio/Music.cr"
require "./wrappers/audio/Sound.cr"

require "./wrappers/basic/CollisionShapes.cr"
require "./wrappers/basic/Coords.cr"
require "./wrappers/basic/Rect.cr"

require "./wrappers/graphics/Color.cr"
require "./wrappers/graphics/Drawable.cr"
require "./wrappers/graphics/Font.cr"
require "./wrappers/graphics/Renderer.cr"
require "./wrappers/graphics/RenderQueue.cr"
require "./wrappers/graphics/Shapes.cr"
require "./wrappers/graphics/Sprite.cr"
require "./wrappers/graphics/Text.cr"
require "./wrappers/graphics/Texture.cr"
require "./wrappers/graphics/View.cr"
require "./wrappers/graphics/Window.cr"

require "./wrappers/input/Event.cr"
require "./wrappers/input/Keyboard.cr"
require "./wrappers/input/Mouse.cr"

require "./wrappers/user/AI.cr"
require "./wrappers/user/Entity.cr"
require "./wrappers/user/EntityGroup.cr"
require "./wrappers/user/Limiter.cr"
require "./wrappers/user/Param.cr"
require "./wrappers/user/Scene.cr"

def load_engine_library(rb)
  Anyolite.wrap(rb, SDC, verbose: true)
end
