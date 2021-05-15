module SDC

	# Other utility methods for rapid development

	def self.draw_texture(index: nil, file_index: nil, filename: nil, z: 0, draw_window: SDC.window, color: SDC::COLOR_WHITE, scale: SDC.xy(1, 1), coordinates: SDC::Coordinates.new)
		texture = SDC::Data.load_texture(index, file_index: file_index, filename: filename)
		puts "Warning: Texture index #{index} not loaded." if !texture

		sprite = SDC::Sprite.new
		sprite.link_texture(texture)
		sprite.color = color
		sprite.scale = scale
		draw_window.draw_translated(sprite, z, coordinates)
	end

	def self.draw_text(index: nil, font_index: nil, font: nil, text: "", size: 10, z: 0, draw_window: SDC.window, coordinates: SDC::Coordinates.new, color: nil)
		text_obj = SDC::Data.load_text(index = index, content: text, size: size, font_index: font_index, font: font)
		puts "Warning: Text index #{index} not loaded." if !text_obj

		text_obj.color = color if color
		draw_window.draw_translated(text_obj, z, coordinates)
	end

	def self.play_sound(index: nil, file_index: nil, filename: nil, volume: 100.0, pitch: 1.0)
		sound_buffer = SDC::Data.load_sound_buffer(index, file_index: file_index, filename: filename)

		sound = SDC::Sound.new
		sound.link_sound_buffer(sound_buffer)
		sound.volume = volume
		sound.pitch = pitch
		sound.play
	end

	def self.play_music(index: nil, file_index: nil, filename: nil, volume: 100.0, pitch: 1.0)
		music = SDC::Data.load_music_track(index, file_index: file_index, filename: filename)

		music.volume = volume
		music.pitch = pitch
		music.play
	end

	def self.stop_music(index, file_index: nil, filename: nil)
		music = SDC::Data.load_music_track(index, file_index: file_index, filename: filename)
		
		music.stop
	end

end