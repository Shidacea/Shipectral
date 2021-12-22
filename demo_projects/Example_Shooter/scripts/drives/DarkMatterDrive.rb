module ShooterTest
	class DarkMatterDrive < Drive
		self.identification = 3

		self.boost = 0.5
		self.max_speed = 250.0
		self.brake = 0.5
		self.friction = 0.0

		self.heating_rate = 0.025
		self.cooldown_rate = 0.05

		def generate_particles(ship)
			rand(3).times do
				particle_shape = SF::RectangleShape.new
				particle_shape.size = SDC.xy(6, 6)
				particle_shape.origin = SDC.xy(3, 3)

				new_position = ship.position + ship.direction * (-30.0) + ship.direction_normal * ((rand(3) - 1) * 15.0)
				new_velocity = ship.velocity + ship.direction * (-5.0)

				particle = Particle.new(shape: particle_shape, lifetime: rand(256), position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
					particle.color = SDC.color(128, particle.lifetime * 0.5, 128, alpha: particle.lifetime)
				end

				SDC.scene.add_particle particle
			end
		end

	end
end