module SDC
  module AI
		module Helper
			# TODO: Rather implement this with Anyolite as soon as possible
			def self.create_fiber_from_proc(proc)
				Fiber.new(&proc)
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

puts "AI module loaded"