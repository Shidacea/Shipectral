module ShooterTest
	class Asteroid < SDC::Entity
		register_id :Asteroid

		self.define_class_property :z, default: Z_ASTEROID
		self.define_class_property :mass, default: 1000.0

		SDC::Data.load_texture(:Asteroid, filename: "assets/graphics/Asteroid.png")
		add_sprite(index: 0, texture_index: :Asteroid, rect: SF::IntRect.new(0, 0, 400, 400), origin: SDC.xy(200, 200))

		add_shape(index: 0, type: SF::CollisionShapeCircle, radius: 200.0)
		add_box(index: 0, size: SDC.xy(400.0, 400.0), offset: SDC.xy(0.0, 0.0), origin: SDC.xy(200, 200))

		def at_init
			@new_velocity_diff = SDC.xy
		end

		def at_entity_collision(other_entity, hurtshape, hitshape)
			dv = @velocity - other_entity.velocity
			dx = @position - other_entity.position
			
			reduced_mass = 2.0 * other_entity.mass / (other_entity.mass + self.mass)
			@new_velocity_diff += dx * reduced_mass * (-dv.dot(dx) / dx.squared_norm)
		end

		def custom_pre_physics
			@velocity += @new_velocity_diff
			@new_velocity_diff = SDC.xy
		end

		def custom_draw(window)
			#draw_shape = SF::DrawShapeRectangle.new
			#draw_shape.get_from(@boxes[0])
			#window.draw_translated(draw_shape, z: 10, coords: @position)
		end

	end
	
end