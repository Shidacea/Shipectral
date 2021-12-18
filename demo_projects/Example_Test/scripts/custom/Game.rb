# Structure for temporary game data
# Feel free to customize and extend this class

module SDC
	class Game < SDC::BaseGame

		def initialize
			# Initialize base game values
			super
			# Gravity
			@gravity = SDC.xy(0, 30.0) * (@meter / @second**2)
		end

	end
end