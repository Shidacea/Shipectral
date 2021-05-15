module SDC

	def self.handle_backspace_input(text_buffer)
		text_buffer.chop!
	end

	def self.handle_ctrl_backspace_input(text_buffer)
		# Remove the last word and every whitespace after it
		text_buffer.rstrip!
		last_space = text_buffer.rindex(" ")
		if last_space then
			text_buffer[last_space+1..-1] = ""
		else
			text_buffer.clear
		end
	end

	def self.is_ctrl_char(char)
		return (char.ord < 32 || char == C_CTRL_BACK)
	end

	# TODO: Allow specific input class

	def self.process_text_input(event: nil, text_buffer: nil, override: false)
		if event.has_type?(:TextEntered) then
			char = event.text_char

			# Want to filter certain chars? Use the filter method!
			if block_given? then
				filter_result = yield(char, text_buffer)
				char = filter_result if filter_result
				return if override
			end

			if char == C_BACKSPACE then
				self.handle_backspace_input(text_buffer)
			elsif char == C_CTRL_BACK then
				self.handle_ctrl_backspace_input(text_buffer)
			elsif self.is_ctrl_char(char) then

			else
				text_buffer.concat(char)
			end
		end
	end

end