module SPT
	alias Coordinates = SF::Vector2f

	def self.xy(x = 0.0, y = 0.0)
		return Coordinates.new(x, y)	
	end

	@@window = uninitialized SF::RenderWindow

	def self.window
		return @@window
	end

	def self.window=(value)
		@@window = value
	end

	@@scene = SPT::NoScene

	def self.scene
		return @@scene
	end

	def self.scene=(value)
		@@scene = value
	end

	@@draw_width : Int32 = 0
	@@draw_height : Int32 = 0

	def self.set_draw_size(width, height)
		@@draw_width = width
		@@draw_height = height
	end

	def self.draw_width
		return @@draw_width
	end

	def self.draw_height
		return @@draw_height
	end
end