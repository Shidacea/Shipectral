module ShooterTest
	class Ship < SDC::Entity

		# Define new properties
		self.define_class_property :max_health, default: 10
		self.define_class_property :shield, default: 0
		self.define_class_property :weapon, default: nil
		self.define_class_property :drive, default: :CombustionDrive
		self.define_class_property :shields, default: :PhaseShield
		self.define_class_property :z, default: Z_SHIP
		self.define_class_property :mass, default: 1.0
		self.define_class_property :invincibility_time, default: 90.0

		attr_reader :angle, :drives, :shields, :health

		def at_init
			@angle = 0.0
			
			@drives = []
			@shields = []

			@health = self.max_health

			add_drive(self.drive)
			add_shield(self.shield)

			@drive_index = 0
			@shield_index = 0

			@new_velocity_diff = SDC.xy
		end

		def selected_drive
			return @drives[@drive_index]
		end

		def selected_shield
			return @shields[@shield_index]
		end

		def add_drive(drive_symbol)
			@drives.push(ShooterTest.const_get(drive_symbol).new)
		end

		def add_shield(shield_symbol)
			@shields.push(ShooterTest.const_get(shield_symbol).new)
		end

		def rotate_drive(diff)
			@drive_index += diff
			correct_drive_index
		end

		def correct_shapes

		end

		def select_drive(index)
			@drive_index = index
			correct_drive_index
		end

		def correct_drive_index
			@drive_index = @drives.size - 1 if @drive_index >= @drives.size
			@drive_index = 0 if @drive_index < 0
		end

		def rotate(angle_difference)
			@angle += angle_difference * SDC.game.dt
			@sprites[0].rotation += angle_difference * SDC.game.dt
			correct_shapes
		end

		def boost
			unless selected_drive.overheated then
				unless has_max_speed then
					accelerate(direction * selected_drive.boost)
				end
				selected_drive.run
				selected_drive.generate_particles(self)
			end
		end

		def brake
			accelerate(velocity * (-selected_drive.brake))
		end

		def direction
			return SDC.xy(Math::sin(@angle / 180.0 * Math::PI), -Math::cos(@angle / 180.0 * Math::PI))
		end

		def direction_normal
			return SDC.xy(Math::cos(@angle / 180.0 * Math::PI), Math::sin(@angle / 180.0 * Math::PI))
		end

		def custom_update
			@velocity *= (1.0 - selected_drive.friction)
			
			@drives.each do |drive|
				drive.update
			end

			@shields.each do |shield|
				shield.update
			end

			if selected_shield.invincibility then
				@sprites[0].color = SDC::COLOR_TRANSPARENT if selected_shield.invincibility % 4 < 2
				@sprites[0].color = SDC::COLOR_WHITE if selected_shield.invincibility % 4 >= 2
			else
				@sprites[0].color = SDC::COLOR_WHITE
			end
		end


		def has_max_speed
			return @velocity.squared_norm >= selected_drive.max_speed
		end

		def update_shapes
			
		end

		def at_entity_collision(other_entity, hurtshape, hitshape)
			return if selected_shield.invincibility

			dv = @velocity - other_entity.velocity
			dx = @position - other_entity.position
			
			reduced_mass = 2.0 * other_entity.mass / (other_entity.mass + self.mass)
			@new_velocity_diff += dx * reduced_mass * (-dv.dot(dx) / dx.squared_norm)

			damage(rand(10))

			selected_shield.hit
		end

		def custom_pre_physics
			@velocity += @new_velocity_diff
			@new_velocity_diff = SDC.xy
		end

		def heal(value)
			@health += value
			@health = @health.clamp(0, self.max_health)
		end

		def damage(value)
			@health -= value
			@health = @health.clamp(0, self.max_health)
		end

		def health_percentage
			return @health / self.max_health
		end

	end
end