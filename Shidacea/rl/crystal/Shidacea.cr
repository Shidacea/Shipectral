SPT::Features.ensure("rl")

alias Rl = LibRaylib

require "./wrappers/Color.cr"
require "./wrappers/Font.cr"
require "./wrappers/Rectangle.cr"
require "./wrappers/ShapeBox.cr"
require "./wrappers/Text.cr"
require "./wrappers/Vector2.cr"
require "./wrappers/Window.cr"

# NOTE: The raylib structs are wrapped separately in Ruby, but still included as alias in the SDC module in Crystal
# Essentially, this allows for an equivalent syntax, while avoiding path resolution problems with Anyolite

@[Anyolite::ExcludeConstant("Color")]
@[Anyolite::ExcludeConstant("Font")]
@[Anyolite::ExcludeConstant("Rectangle")]
@[Anyolite::ExcludeConstant("Vector2")]
module SDC
  alias Vector2 = Rl::Vector2
  alias Color = Rl::Color
  alias Font = Rl::Font
  alias Rectangle = Rl::Rectangle
end

def load_engine_library(rb)
  Anyolite.wrap(rb, SDC, verbose: true)
  Anyolite.wrap(rb, Rl::Color, under: SDC, verbose: true)
  Anyolite.wrap(rb, Rl::Font, under: SDC, verbose: true)
  Anyolite.wrap(rb, Rl::Rectangle, under: SDC, verbose: true)
  Anyolite.wrap(rb, Rl::Vector2, under: SDC, verbose: true)
end