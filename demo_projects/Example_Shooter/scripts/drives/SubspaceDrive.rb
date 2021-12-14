module ShooterTest
	class SubspaceDrive < Drive
		self.identification = 7

		self.boost = 0.5
		self.max_speed = 10000.0
		self.brake = 0.01
		self.friction = 0.001

		self.heating_rate = 0.002
		self.cooldown_rate = 0.0005

		def generate_particles(ship)
			return if rand(3) != 0
			particle_shape = SF::DrawShapeCircle.new
			particle_shape.radius = 50
			particle_shape.origin = SDC.xy(50, 50)

			new_position = ship.position + ship.direction * (-30.0)
			new_velocity = SDC.xy(0, 0)

			particle = Particle.new(shape: particle_shape, lifetime: 255, position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
				particle.color = SF::Color.new(128, 0, particle.lifetime, particle.lifetime * 0.25)
				particle.shape.radius *= 1.01
				particle_shape.origin *= 1.01
			end

			SDC.scene.add_particle particle
		end

	end
end