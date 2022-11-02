module SDC
  module AI
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