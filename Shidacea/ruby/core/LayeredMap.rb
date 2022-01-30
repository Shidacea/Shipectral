module SDC
	class Map
		attr_accessor :z
	end

	class LayeredMap

		include SDCMeta::AIBackend

		# TODO: Remove this if unneeded
		attr_accessor :map_layers, :config

		def initialize(tile_width: 50, tile_height: 50, view_width: 20, view_height: 20)
			@tile_width = tile_width
			@tile_height = tile_height
			@view_width = view_width
			@view_height = view_height

			@map_layers = []

			@config = nil
			setup_ai
		end

		def set_config(name)
			@config = SDC::Data::map_configs[name].dup
			@map_layers.each do |layer|
				layer.link_tileset(SDC::Data::tilesets[@config.tileset_index])
			end
		end

		def load_from_raw_format_file(filename)
			full_filename = SDC::Script.get_full_filename(filename)

			if !File.exists?(full_filename)
        raise "File not found: #{full_filename}"
      end

			first_line = true
			layer = 0

			File.foreach(full_filename).each do |line|
				split_values = line.split

				if first_line
					@number_of_layers = split_values[0].to_i

					@width = split_values[1].to_i
					@height = split_values[2].to_i

					first_line = false
				elsif split_values[0] == "L"
					layer = split_values[1].to_i

					new_layer = SDC::Map.new(@view_width, @view_height, @tile_width, @tile_height)

					other_options = split_values[2..-1]
					if other_options.size > 0
						0.upto(other_options.size / 2 - 1) do |i|
							option = other_options[2 * i]
							option_value = other_options[2 * i + 1]

							if option == "B"
								new_layer.background_tile = option_value.to_i
							elsif option == "Z"
								new_layer.z = option_value.to_f
							elsif option == "A"
								new_layer.animated = (option_value.to_i == 1 ? true : false)
							end
						end
					end

					new_layer.content.set_size(@width, @height)

					new_layer.collision_active = (layer == @number_of_layers - 1)	# TODO

					@map_layers.push(new_layer)
				elsif split_values.empty?
				else
					@map_layers[layer].content.add_line_from_array(line.split.map{|x| x.to_i})
				end
			end

			# Can be used for more detailed collisions
			@tile_shape = SDC::CollisionShapeBox.new(offset: SDC.xy(-@tile_width * 0.5, -@tile_height * 0.5), size: SDC.xy(@tile_width, @tile_height))
		end

		def test_collision_with_entity(entity)
			boxes = entity.boxes
			ex = entity.position.x
			ey = entity.position.y

			any_result = false

			boxes.each do |box|
				ix_low = ((ex + box.offset.x - box.origin.x * box.scale.x) / @tile_width).floor
				iy_low = ((ey + box.offset.y - box.origin.y * box.scale.y) / @tile_height).floor
				ix_high = ((ex + box.size.x * box.scale.x + box.offset.x - box.origin.x * box.scale.x) / @tile_width).floor
				iy_high = ((ey + box.size.y * box.scale.y + box.offset.y - box.origin.y * box.scale.y) / @tile_height).floor

				# TODO: Implement default value for map layers, so this loop can be extended over undefined areas

				[0, ix_low].max.upto([ix_high, @width - 1].min) do |ix|
					[0, iy_low].max.upto([iy_high, @height - 1].min) do |iy|
						@map_layers.each do |layer|
							next if !layer.collision_active
							# TODO: Include detection for empty tiles and tile properties in general
							tile_id = layer[ix, iy]
							result = layer.tileset.tiles[tile_id].solid
							any_result = true
							# NOTE: Use   Collider.test(<shape>, <pos>, @tile_shape, SDC.xy((ix + 0.5) * @tile_width, (iy + 0.5) * @tile_height))   for detailed collisions
							return true if result
						end
					end
				end
			end
			return !any_result
		end

		def update
			tick_ai
		end

		def reload(position)
			@map_layers.each {|layer| layer.reload(position)}
		end

		def draw(window, offset, dz: 0)
			@map_layers.each do |layer|
				window.draw_translated(layer, z: (layer.z ? layer.z : 0) + dz, at: offset)
			end
		end

		def master_ai_script
			@config.run_script if @config
		end

	end

end