module SDC
	module Data

		# If an actual symbol is not needed, e.g. for one-time draw routines
		SYMBOL_PREFIX = "_UNKNOWN_"

		extend SDCMeta::DataStorage

		self.define_new_data_type(:entity, plural: :entities)
		self.define_new_data_type(:font)
		self.define_new_data_type(:text)
		self.define_new_data_type(:tileset)
		self.define_new_data_type(:texture)
		self.define_new_data_type(:sound_buffer)
		self.define_new_data_type(:music_track)
		self.define_new_data_type(:map_config)
		self.define_new_data_type(:filename)

		self.create_loading_method(:texture, SDC::Texture, :load_from_file)
		self.create_loading_method(:sound_buffer, SDC::SoundBuffer, :load_from_file)
		self.create_loading_method(:music_track, SDC::Music, :open_from_file)
		self.create_loading_method(:font, SDC::Font, :load_from_file)

		def self.load_text(index = nil, content: nil, size: 10, font_index: nil, font: nil)
			if font && font_index then
				@fonts[font_index] = font
			else
				font = font_index ? self.load_font(font_index) : font
			end

			if !index && !content then
				raise ArgumentError("Neither index nor content given.")
			elsif !index then
				# TODO: Use object ID or magic number instead
				index = (SYMBOL_PREFIX + content).to_sym
			elsif !content then
				content = self.texts[index]
			end

			if !self.texts[index] then
				self.add_text(SDC::Text.new(content, font, size), index: index)
			else
				# TODO: Update font
				self.texts[index].string = content
				self.texts[index].character_size = size
			end

			return self.texts[index]
		end

	end
end