class TestShape

	attr_accessor :draw_shape, :collision_shape, :pos, :z, :counter

	def initialize(draw_shape, collision_shape, pos, z, counter)
		@draw_shape = draw_shape
		@collision_shape = collision_shape
		@z = z
		@pos = pos
		@counter = counter
		randomize_color
		update
	end

	def update
		@draw_shape.fill_color = @color
		@draw_shape.get_from(@collision_shape)
	end

	def draw
		SDC.window.draw_translated(@draw_shape, @z, @pos)
	end

	def randomize_color
		@color = SDC::Color.new(rand(256), rand(256), rand(256), 196)
	end

	def self.new_circle(pos: SDC.xy, offset: SDC.xy, radius: 0.0, z: 0, counter: counter)
		draw_shape = SDC::DrawShapeCircle.new
		collision_shape = SDC::CollisionShapeCircle.new(offset, radius)
		return self.new(draw_shape, collision_shape, pos, z, counter)
	end

	def self.new_box(pos: SDC.xy, offset: SDC.xy, size: SDC.xy, z: 0, counter: counter)
		draw_shape = SDC::DrawShapeRectangle.new
		collision_shape = SDC::CollisionShapeBox.new(offset, size)
		return self.new(draw_shape, collision_shape, pos, z, counter)
	end

	def self.new_triangle(pos: SDC.xy, offset: SDC.xy, side_1: SDC.xy, side_2: SDC.xy, z: 0, counter: counter)
		draw_shape = SDC::DrawShapeTriangle.new
		collision_shape = SDC::CollisionShapeTriangle.new(offset, side_1, side_2)
		return self.new(draw_shape, collision_shape, pos, z, counter)
	end

end