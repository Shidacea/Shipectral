module ShooterTest
	class IonDrive < Drive
		self.identification = 1

		self.boost = 0.05
		self.max_speed = 250.0
		self.brake = 0.05
		self.friction = 0.005

		self.heating_rate = 0.0001
		self.cooldown_rate = 0.05

		def generate_particles(ship)
			rand(5).times do
				particle_shape = SF::DrawShapeRectangle.new
				particle_shape.size = SDC.xy(2, 2)
				particle_shape.origin = SDC.xy(1, 1)

				new_position = ship.position + ship.direction * (-30.0) + ship.direction_normal * ((rand(3) - 1) * 15.0)
				new_velocity = ship.velocity + ship.direction * (-20.0)

				particle = Particle.new(shape: particle_shape, lifetime: rand(64), position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
					particle.color = SF::Color.new(particle.lifetime * 4, 0, particle.lifetime * 4, alpha: particle.lifetime * 4)
				end

				SDC.scene.add_particle particle
			end
		end

	end
end