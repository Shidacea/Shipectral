module ShooterTest
	class Shield
		attr_reader :invincibility

		extend SDCMeta::ClassProperty
		
		self.define_class_property(:invincibility_time, default: 90.0)

		def initialize
			@invicibility = false
		end

		def update
			if @invincibility then
				@invincibility -= SDC.game.dt
				if @invincibility <= 0 then
					@invincibility = false
				end
			end
		end

		def hit
			@invincibility = self.invincibility_time
		end
		
	end
end