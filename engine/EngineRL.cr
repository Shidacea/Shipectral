{% if flag?(:win32) %}
  @[Link("msvcrt")]
  @[Link("Ws2_32")]
  @[Link("Winmm")]
  @[Link("Gdi32")]
  @[Link("User32")]
  @[Link("Shell32")]

  # The next line seems to be necessary due to a library conflict with mruby
  # Which is weird, because a minimal working example with raylib-cr and Anyolite does not seem to reproduce this error

  @[Link(ldflags: "/link /FORCE:MULTIPLE")]
{% end %}

require "raylib-cr"

SPT::Features.add("rl")

def load_rl_wrappers(rb)
end