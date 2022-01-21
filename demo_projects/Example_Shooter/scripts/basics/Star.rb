module ShooterTest
	class Star

		def initialize(position: SDC.xy, color: SDC.color(255, 255, 255, alpha: 255))
			@position = position
			@color = color
			@shape = SDC::Graphics::Shapes::Rectangle.new
			@shape.fill_color = color
			@shape.size = SDC.xy(3, 3)
		end

		def draw(window)
			if SDC.scene.in_cam(@position) then
				window.draw_translated(@shape, z: Z_STAR, at: @position)
			end
		end

	end
end