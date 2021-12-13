module SDC

	# Script routines for easier readability, directly referencing other methods

	def self.key_pressed?(key, override_text_input: false)
		return @window.has_focus? && (override_text_input || !@text_input) && SDC::EventKey.const_defined?(key) && SDC::EventKey.is_pressed?(SDC::EventKey.const_get(key))
	end

	def self.key(key)
		return SDC::EventKey.const_get(key) if SDC::EventKey.const_defined?(key)
	end

	def self.mouse_button_pressed?(button)
		return @window.has_focus? && SDC::EventMouse.const_defined?(button) && SDC::EventMouse.is_button_pressed?(SDC::EventMouse.const_get(button))
	end

	def self.mouse_button(button)
		return SDC::EventMouse.const_get(button) if SDC::EventMouse.const_defined?(button)
	end

	# Returns an integer array with two elements of the pixel coordinates.
	# Therefore, window scaling WILL change the dimensions of the area the mouse can operate in.
	def self.get_mouse_pos
		return SDC::EventMouse.get_position(SDC.window)
	end

	# Returns the mouse coordinate for the current view.
	# If you want to check for another view, you need to activate it first or execute any mouse check methods in a view block.
	def self.get_mouse_coords
		return SDC::EventMouse.get_coordinates(SDC.window)
	end

	def self.get_mouse_point
		return SDC::CollisionShapePoint.new(self.get_mouse_coords)
	end

	def self.mouse_touching?(shape, offset: SDC.xy)
		return SDC::Collider.test(self.get_mouse_point, SDC.xy, shape, offset)
	end

	def self.right_klick?
		return self.mouse_button_pressed?(:Right)
	end

	def self.left_klick?
		return self.mouse_button_pressed?(:Left)
	end

end