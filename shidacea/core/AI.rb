# Simple AI routine model.
# The basic principle is that each entity has a master AI routine, which gets called once per frame.
# Parallel to the master AI another secondary AI is running, also once per frame.
# However, both AI processes have different tasks.
# The master AI controls which AI page should be active for the secondary AI.
# The secondary AI should be used for the actual entity routines.
# This way, the secondary AI routine may pause (using SDC::wait), while AI page switching is still possible.
# Switching AI pages furthermore preserves the waiting status and any local variables.
# The main usage is to switch between different AI pages if the entity collides with another entity, for example, even if the current AI page is waiting.
# The AI system itself is designed to avoid infinite loops in scripts as far as possible, while preserving total control.

module SDC
	module AI

		class Script
		
			def initialize(&block)
				@fiber = Fiber.new {block.call}
			end

			def tick
				@fiber.resume
			end

			def running?
				return @fiber.alive?
			end

		end

		def self.done
			Fiber.yield
		end

		def self.wait(n)
			n.times {done}
		end

		def self.once
			yield
			done
		end

		def self.times(n)
			n.times do
				yield
				done
			end
		end

		def self.forever
			loop do
				yield
				done
			end
		end

	end

end