module ShooterTest
	class Space

		attr_reader :width, :height

		def initialize(width: 100, height: 100, star_count: 1000)
			@width = width
			@height = height
			@stars = []
			star_count.times do
				@stars.push(Star.new(position: SDC.xy(rand(width), rand(height))))
			end
			# TODO: Partition these
			# TODO: Make this a map
		end

		def draw(window)
			@stars.each do |star|
				star.draw(window)
			end
		end

	end
end