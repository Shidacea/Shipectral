module ShooterTest
	class ImpulseDrive < Drive
		self.identification = 2

		self.boost = 0.5
		self.max_speed = 300.0
		self.brake = 0.05
		self.friction = 0.005

		self.heating_rate = 0.002
		self.cooldown_rate = 0.005

		def generate_particles(ship)
			rand(3).times do
				particle_shape = SDC::DrawShapeRectangle.new
				particle_shape.size = SDC.xy(6, 6)
				particle_shape.origin = SDC.xy(3, 3)

				new_position = ship.position + ship.direction * (-30.0) + ship.direction_normal * ((rand(3) - 1) * 15.0)
				new_velocity = ship.velocity + ship.direction * (-5.0)

				particle = Particle.new(shape: particle_shape, lifetime: rand(256), position: new_position, velocity: new_velocity, z: Z_PARTICLE) do
					particle.color = SDC::Color.new(0, particle.lifetime * 0.5, 255, particle.lifetime)
				end

				SDC.scene.add_particle particle
			end
		end

	end
end