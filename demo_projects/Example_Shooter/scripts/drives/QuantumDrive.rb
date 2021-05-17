module ShooterTest
	class QuantumDrive < Drive
		self.identification = 8

		self.boost = 5000.0
		self.max_speed = 10.0
		self.brake = 0.05
		self.friction = 1.0

		self.heating_rate = 0.1
		self.cooldown_rate = 0.005

		def generate_particles(ship)
			particle_shape = SDC::DrawShapeCircle.new
			particle_shape.radius = 50
			particle_shape.origin = SDC.xy(50, 50)

			new_position = ship.position + ship.direction * (-30.0)
			new_velocity = SDC.xy(0, 0)

			particle = Particle.new(shape: particle_shape, lifetime: 127, position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
				particle.color = SDC::Color.new(particle.lifetime * 2, particle.lifetime * 1.5, particle.lifetime * 2, particle.lifetime * 0.2)
				particle.position = ship.position + ship.direction * (-30.0)
				particle.shape.radius *= 1.2
				particle_shape.origin *= 1.2
			end

			SDC.scene.add_particle particle
		end

	end
end