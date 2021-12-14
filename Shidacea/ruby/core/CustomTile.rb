# If you want to add custom tile properties to your game you can use this class.
# Make sure to ALWAYS derive from Tile to get the integration working.
# Certain attributes like animations and the solidity are implemented in the base class.

module SDC
	class CustomTile < SDC::Tile

		def at_init

		end

		def initialize
			super
			at_init
		end

	end
end