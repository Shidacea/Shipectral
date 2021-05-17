module ShooterTest
	class WarpDrive < Drive
		self.identification = 5

		self.boost = 0.75
		self.max_speed = 500.0
		self.brake = 0.1
		self.friction = 0.0001

		self.heating_rate = 0.002
		self.cooldown_rate = 0.0005

		def generate_particles(ship)
			rand(2).times do
				particle_shape = SDC::DrawShapeLine.new
				length = rand(300)
				particle_shape.line = ship.direction * (-length) + ship.direction_normal * (50 * rand - 25)

				new_position = ship.position + ship.direction * 30.0
				new_velocity = ship.velocity + ship.direction * (-2.0)

				particle = Particle.new(shape: particle_shape, lifetime: rand(64), position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
					particle.shape.outline_color = SDC::Color.new(255 - rand(64), 255 - rand(64), 255 - rand(64), particle.lifetime * 4)
					particle.shape.line = (ship.direction * (-length) + ship.direction_normal * (50 * rand - 25)) * ship.velocity.squared_norm * 0.01
					particle.position = ship.position + ship.direction * 30.0
					particle.velocity = ship.velocity + ship.direction * (-2.0)
				end

				SDC.scene.add_particle particle
			end
		end

	end
end