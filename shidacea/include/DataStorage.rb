module SDCMeta
	module DataStorage

		# If an actual symbol is not needed, e.g. for one-time draw routines
		SYMBOL_PREFIX = "_UNKNOWN_"

		def define_new_data_type(name, as_hash: true, plural: name.to_s + "s")
			@container_list = {} if !@container_list
			@plural_list = {} if !@plural_list

			instance_variable_set("@#{plural}", (as_hash ? {} : []))
			data = instance_variable_get("@#{plural}")
			define_singleton_method("add_#{name}") do |obj, index: nil|
				if !index then
					if as_hash then
						raise("No index for hash data type given") 
					else
						index = data.size
					end
				end
				data[index] = obj
				return index
			end
		
			define_singleton_method(plural) do
				return data
			end

			@plural_list[name] = plural
			@container_list[name] = instance_variable_get("@#{plural}")
		end

		def clear_containers
			@container_list.each do |container|
				container.clear
			end
		end

		def create_loading_method(name, obj_class, load_method)
			define_singleton_method("load_#{name}") do |index = nil, file_index: nil, filename: nil|
				if !index then
					if !file_index && !filename then
						raise ArgumentError.new("Neither file_index nor filename were given.")
					elsif !file_index then
						index = (SYMBOL_PREFIX + filename).to_sym
					elsif !filename then
						index = file_index.to_sym
					else
						index = file_index.to_sym
					end
				end
				if !@container_list[name][index] then
					if !file_index && !filename then
						raise ArgumentError.new("Neither file_index nor filename were given.")
					elsif !filename then
						filename = @filenames[file_index]
						raise RuntimeError.new("File index #{file_index} has no associated filename.")
					elsif file_index && file_name then
						add_filename(filename, index: file_index)
					end

					obj = obj_class.new
					obj.method(load_method).call(filename)
					self.singleton_method("add_#{name}".to_sym).call(obj, index: index)
				end

				return @container_list[name][index]
			end
		end

	end
end