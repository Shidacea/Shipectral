module ShooterTest
	class Star

		def initialize(position: SDC.xy, color: SDC::Color.new(255, 255, 255, 255))
			@position = position
			@color = color
			@shape = SDC::DrawShapeRectangle.new
			@shape.fill_color = color
			@shape.size = SDC.xy(3, 3)
		end

		def draw(window)
			if SDC.scene.in_cam(@position) then
				window.draw_translated(@shape, Z_STAR, @position)
			end
		end

	end
end