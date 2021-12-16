module ShooterTest
	class Particle

		attr_accessor :gone, :position, :velocity, :color, :lifetime, :z, :shape, :texture_index

		def initialize(texture_index: nil, shape: nil, lifetime: 1, z: 0, position: SDC.xy, velocity: SDC.xy, color: SF::Color.new(255, 255, 255, alpha: 255), &update_block)
			@lifetime = lifetime
			@gone = false
			@z = z
			@position = position
			@velocity = velocity
			@update_block = update_block
			@shape = shape
			@texture_index = texture_index
			@color = color
		end

		def update
			@lifetime -= 1
			@gone = true if @lifetime <= 0
			@position += @velocity * SDC.game.dt

			@update_block&.call unless @gone
		end

		def draw(window)
			if SDC.scene.in_cam(@position, tolerance: 100) then
				if @shape then
					@shape.fill_color = @color
					window.draw_translated(@shape, z: @z, coords: @position)

				elsif @texture_index then
					# TODO
					SDC.draw_texture(index: @texture_index, z: @z, coordinates: @position, window: window)
				end
			end
		end

	end
end