module SPT
  # Common control sequences

  C_NULL      = "\0"
  C_BELL      = "\a"
  C_BACKSPACE = "\b"
  C_TAB       = "\t"
  C_NEWLINE   = "\n"
  C_VERT_TAB  = "\v"
  C_FORM_FEED = "\f"
  C_CAR_RET   = "\r"
  C_CTRL_Z    = "z"
  C_ESCAPE    = "\e"
  C_CTRL_BACK = "\x7F"

  # Empty {SDC::Coordinates} object as a constant
  # Using this might save time on functions needing a constant vector
  XY0 = SPT::Coordinates.new(0.0, 0.0).freeze

  # Colors

  COLOR_RED   = SF::Color::Red
  COLOR_GREEN = SF::Color::Green
  COLOR_BLUE  = SF::Color::Blue

  COLOR_BLACK = SF::Color::Black
  COLOR_WHITE = SF::Color::White

  COLOR_TRANSPARENT = SF::Color::Transparent

  COLOR_YELLOW  = SF::Color::Yellow
  COLOR_CYAN    = SF::Color::Cyan
  COLOR_MAGENTA = SF::Color::Magenta
end
