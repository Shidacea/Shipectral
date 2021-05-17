module ShooterTest
	class Drive

		attr_reader :max_speed, :boost, :brake, :overheated, :friction

		extend SDCMeta::ClassProperty
		
		self.define_class_property(:boost, default: 0.5)
		self.define_class_property(:max_speed, default: 100.0)
		self.define_class_property(:brake, default: 0.05)
		self.define_class_property(:friction, default: 0.0)
		self.define_class_property(:heating_rate, default: 0.0)
		self.define_class_property(:heat_threshold, default: 1.0)
		self.define_class_property(:cooldown_heat, default: 0.0)
		self.define_class_property(:cooldown_rate, default: 0.0)

		self.define_class_property(:identification, default: 0)

		def initialize
			@heat_level = 0
			@overheated = false
			@running = false
		end

		def heat_percentage
			return (@heat_level / self.heat_threshold).clamp(0, 1)
		end

		def run
			@heat_level += self.heating_rate * SDC.game.dt
			if @heat_level >= self.heat_threshold then
				@overheated = true
			end
			@running = true
		end

		def idle
			@heat_level -= self.cooldown_rate * SDC.game.dt
			if @heat_level < self.cooldown_heat then
				@overheated = false
			end
			@heat_level = 0 if @heat_level < 0
		end

		def update
			idle if !@running
			@running = false
		end

		def generate_particles(ship)

		end
		
	end
end