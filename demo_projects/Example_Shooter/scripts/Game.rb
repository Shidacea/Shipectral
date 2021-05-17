# Structure for temporary game data
# Feel free to customize and extend this class

module ShooterTest
	class Game < SDC::BaseGame

		def initialize
			# Initialize base game values
			super
			@dt = 1.0
		end

	end
end