module SDC

	# Common control sequences

	C_NULL = "\0"
	C_BELL = "\a"
	C_BACKSPACE = "\b"
	C_TAB = "\t"
	C_NEWLINE = "\n"
	C_VERT_TAB = "\v"
	C_FORM_FEED = "\f"
	C_CAR_RET = "\r"
	C_CTRL_Z = "\z"
	C_ESCAPE = "\e"
	C_CTRL_BACK = "\x7F"

	# Empty {SF::Vector2f} object as a constant
	# Using this might save time on functions needing a constant vector
	XY0 = SDC.xy(0.0, 0.0).freeze

	# Colors

	COLOR_RED = SF::Color.new(255, 0, 0).freeze
	COLOR_GREEN = SF::Color.new(0, 255, 0).freeze
	COLOR_BLUE = SF::Color.new(0, 0, 255).freeze

	COLOR_BLACK = SF::Color.new(0, 0, 0).freeze
	COLOR_WHITE = SF::Color.new(255, 255, 255).freeze

	COLOR_TRANSPARENT = SF::Color.new(0, 0, 0, alpha: 0).freeze

	COLOR_YELLOW = SF::Color.new(255, 255, 0).freeze
	COLOR_CYAN = SF::Color.new(0, 255, 255).freeze
	COLOR_MAGENTA = SF::Color.new(255, 0, 255).freeze

end