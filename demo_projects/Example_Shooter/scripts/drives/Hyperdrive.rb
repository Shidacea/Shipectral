module ShooterTest
	class HyperDrive < Drive
		self.identification = 6

		self.boost = 20.0
		self.max_speed = 5000.0
		self.brake = 0.05
		self.friction = 0.1

		self.heating_rate = 0.05
		self.cooldown_rate = 0.01

		def generate_particles(ship)
			particle_shape = SDC::DrawShapeCircle.new
			particle_shape.radius = 50
			particle_shape.origin = SDC.xy(50, 50)

			new_position = ship.position + ship.direction * (-30.0)
			new_velocity = SDC.xy(0, 0)

			particle = Particle.new(shape: particle_shape, lifetime: 255, position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
				particle.color = SDC::Color.new(127, particle.lifetime, 255, particle.lifetime * 0.25)
				particle.shape.radius *= 1.0075
				particle_shape.origin *= 1.0075
			end

			SDC.scene.add_particle particle
		end

	end
end