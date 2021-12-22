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

	COLOR_RED = SDC.color(255, 0, 0).freeze
	COLOR_GREEN = SDC.color(0, 255, 0).freeze
	COLOR_BLUE = SDC.color(0, 0, 255).freeze

	COLOR_BLACK = SDC.color(0, 0, 0).freeze
	COLOR_WHITE = SDC.color(255, 255, 255).freeze

	COLOR_TRANSPARENT = SDC.color(0, 0, 0, alpha: 0).freeze

	COLOR_YELLOW = SDC.color(255, 255, 0).freeze
	COLOR_CYAN = SDC.color(0, 255, 255).freeze
	COLOR_MAGENTA = SDC.color(255, 0, 255).freeze

end