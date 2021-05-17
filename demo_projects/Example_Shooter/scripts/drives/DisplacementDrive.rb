module ShooterTest
	class DisplacementDrive < Drive
		self.identification = 4

		self.boost = 1.0
		self.max_speed = 200.0
		self.brake = 0.05
		self.friction = 0.1

		self.heating_rate = 0.0005
		self.cooldown_rate = 0.0001

		def generate_particles(ship)
			rand(3).times do
				particle_shape = SDC::DrawShapeRectangle.new
				particle_shape.size = SDC.xy(10, 10)
				particle_shape.origin = SDC.xy(5, 5)

				new_position = ship.position + ship.direction * (-30.0) + ship.direction_normal * ((rand(3) - 1) * 15.0)
				new_velocity = ship.velocity + ship.direction_normal * (rand - 0.5) * 25.0 - ship.direction * 5.0

				particle = Particle.new(shape: particle_shape, lifetime: rand(256), position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
					particle.color = SDC::Color.new(rand(64), rand(64), rand(64), particle.lifetime)
				end

				SDC.scene.add_particle particle
			end
		end

	end
end