# Extension for events, for better readability

module SF

	class Event

		def has_type?(event_type)
			return self.type == SF::EventType.const_get(event_type)
		end

		def key_pressed?(key)
			return self.key_code == SDC.key(key)
		end

		def mouse_button_pressed?(button)
			return self.mouse_button_code == SDC.mouse_button(button)
		end

		def mouse_left_click?
			return mouse_button_pressed?(:Left)
		end

		def mouse_right_click?
			return mouse_button_pressed?(:Right)
		end

		def mouse_scrolled_down?
			return self.mouse_scroll_wheel == SF::EventMouse::VerticalWheel && self.mouse_scroll_delta < 0.0
		end

		def mouse_scrolled_up?
			return self.mouse_scroll_wheel == SF::EventMouse::VerticalWheel && self.mouse_scroll_delta > 0.0
		end

		def mouse_coordinates
			return SDC.xy(self.mouse_button_x.to_f, self.mouse_button_y.to_f)
		end

		def new_mouse_coordinates
			return SDC.xy(self.mouse_move_x.to_f, self.mouse_move_y.to_f)
		end

		def text_char
			return self.text_unicode.chr("UTF-8")
		end

	end

end