# Very basic button class which can be used directly or serve as a base class

module SDC
	class Button

		attr_accessor :shape, :text, :texture_id

		def initialize(shape: nil, texture_id: nil, text: nil, &function)
			@shape = shape

			# TODO: Texture and text processing
			# TODO: Determine shape from texture if not given directly? Maybe not?
			
			# Call function if given, as long as the button is actually touched by the mouse.
			# Put this in an event handler for right and left clicks to trigger this only if clicked.
			# Preferably, this should only be used for prototyping.
			# For a more sophisticated event handling, use on_mouse_touch.
			function&.call if touched_by_mouse?
		end

		def on_mouse_touch(&function)
			function&.call if touched_by_mouse?
		end

		# TODO: Clicking is wonky, maybe this can be handled better
		def touched_by_mouse?
			return false if !@shape
			return SDC.mouse_touching?(@shape)
		end

		def draw
			# TODO
		end

	end
end