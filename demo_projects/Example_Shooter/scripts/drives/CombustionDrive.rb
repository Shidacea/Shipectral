module ShooterTest
	class CombustionDrive < Drive
		self.identification = 0

		self.boost = 0.2
		self.max_speed = 100.0
		self.brake = 0.01
		self.friction = 0.01

		self.heating_rate = 0.001
		self.cooldown_rate = 0.001

		def generate_particles(ship)
			rand(3).times do
				particle_shape = SF::RectangleShape.new
				particle_shape.size = SDC.xy(6, 6)
				particle_shape.origin = SDC.xy(3, 3)

				new_position = ship.position + ship.direction * (-30.0) + ship.direction_normal * ((rand(3) - 1) * 15.0)
				new_velocity = ship.velocity + ship.direction * (-2.0)

				particle = Particle.new(shape: particle_shape, lifetime: rand(256), position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
					particle.color = SF::Color.new(255, particle.lifetime * 0.5, 0, alpha: particle.lifetime)
				end

				SDC.scene.add_particle particle
			end
		end

	end
end