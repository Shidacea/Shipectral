module SDC

	# Basic attributes

	@window = nil
	@scene = nil
	@next_scene = nil
	@game = nil
	@limiter = nil
	@text_input = nil

	@draw_width = nil
	@draw_height = nil

	# Short expression to create a new {SDC::Coordinates} objects
	def self.xy(x = 0.0, y = 0.0)
		return Coordinates.new(x, y)
	end

	def self.window
		return @window
	end

	def self.window=(value)
		@window = value
	end

	def self.scene
		return @scene
	end

	def self.scene=(value)
		@scene = value
	end

	def self.next_scene
		return @next_scene
	end

	def self.next_scene=(value)
		@next_scene = value
	end

	def self.game
		return @game
	end

	def self.game=(value)
		@game = value
	end

	def self.limiter
		return @limiter
	end

	def self.limiter=(value)
		@limiter = value
	end

	def self.text_input
		return @text_input 
	end

	def self.text_input=(value)
		@text_input = value
	end

	def self.set_draw_size(width, height)
		@draw_width = width
		@draw_height = height
	end

	def self.draw_width
		@draw_width
	end

	def self.draw_height
		return @draw_height
	end

end