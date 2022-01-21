module ShooterTest
	class PlayerShip < Ship
		register_id :PlayerShip

		SDC::Data.load_texture(:PlayerShip, filename: "assets/graphics/Ship.png")
		add_sprite(index: 0, texture_index: :PlayerShip, rect: SDC::IntRect.new(0, 0, 40, 60), origin: SDC.xy(20, 30))

		add_shape(index: 0, type: SDC::CollisionShapeTriangle, offset: SDC.xy(20, 0), origin: SDC.xy(20, 30), side_a: SDC.xy(20, 60), side_b: SDC.xy(-20, 60))
		add_box(index: 0, size: SDC.xy(60.0, 60.0), offset: SDC.xy(0.0, 0.0), origin: SDC.xy(20, 30))

		self.drive = :CombustionDrive
		self.shield = :PhaseShield
		self.max_health = 100

		def correct_shapes
			cos = Math::cos(@angle / 180.0 * Math::PI)
			sin = Math::sin(@angle / 180.0 * Math::PI)

			offset = rotate_vector(SDC.xy(0, -30), cos, sin) + SDC.xy(20, 30)
			side_a = rotate_vector(SDC.xy(20, 30), cos, sin) + SDC.xy(20, 30) - offset
			side_b = rotate_vector(SDC.xy(-20, 30), cos, sin) + SDC.xy(20, 30) - offset

			@shapes[0].side_1 = side_a
			@shapes[0].side_2 = side_b
			@shapes[0].offset = offset
		end

		def rotate_vector(vector, cos, sin)
			return SDC.xy(vector.x * cos - vector.y * sin, vector.x * sin + vector.y * cos)
		end

		def custom_draw(window)
			#draw_shape = SDC::Graphics::Shapes::Triangle.new
			#draw_shape.get_from(@shapes[0])
			#window.draw_translated(draw_shape, z: 10, at: @position)
		end

	end
end