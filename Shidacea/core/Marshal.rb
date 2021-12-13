# Marshal module, supporting basic types (for now)
# Supported types: 
# nil, bools, ints, floats
# Arrays, strings, symbols, hashes
# Objects of classes having the methods marshal_dump and marshal_load

module SDC
	module Marshal

		INDICATOR_NIL = "0".bytes[0]
		INDICATOR_TRUE = "T".bytes[0]
		INDICATOR_FALSE = "F".bytes[0]
		INDICATOR_INT = "i".bytes[0]
		INDICATOR_FLOAT = "f".bytes[0]
		INDICATOR_ARRAY = "[".bytes[0]
		INDICATOR_STRING = "\"".bytes[0]
		INDICATOR_SYMBOL = ":".bytes[0]
		INDICATOR_SYMBOL_LINK = ";".bytes[0]
		INDICATOR_INSTANCE_VAR = "I".bytes[0]
		INDICATOR_HASH = "{".bytes[0]
		INDICATOR_USER_MARSHAL = "U".bytes[0]

		def self.read_byte(file)
			return self.read_bytes(file, 1)[0]
		end

		def self.read_bytes(file, n)
			read_array = file.read(n)
			return read_array.bytes
		end

		def self.read_integer(file)
			length_marker = self.read_byte(file)
			value = 0

			if length_marker == 0 then
				value = 0

			elsif length_marker.between?(5, 127)
				# Value is a small positive int
				value = length_marker - 5

			elsif length_marker.between?(128, 251)
				# Value is a small negative int
				value = length_marker - 256 + 5

			else
				# Value is made out of more than one byte
				negative_value = length_marker > 128
				actual_byte_length = (negative_value ? 256 - length_marker : length_marker)

				length_bytes = self.read_bytes(file, actual_byte_length)

				# Reconstruct the value from the bytes
				power_of_256 = 1
				0.upto(actual_byte_length - 1) do |i|
					if negative_value && i == actual_byte_length - 1 then
						value -= (256 - length_bytes[i]) * power_of_256
					else
						value += length_bytes[i] * power_of_256
						power_of_256 *= 256
					end
				end
			
			end

			return value
		end

		def self.init
			@symbols = []
		end

		def self.add_symbol(sym)
			@symbols.push(sym)
		end

		def self.ref_symbol(index)
			return @symbols[index]
		end

		def self.get_symbol_index(sym)
			return @symbols.index(sym)
		end

		def self.load(file)
			self.init
			version = self.read_bytes(file, 2)

			obj = self.interpret(file)
			return obj
		end

		def self.write_byte(value, file)
			self.write_bytes([value], file)
		end

		def self.write_bytes(values, file)
			file.write(values.pack("C*"))
		end

		def self.dump(value, file)
			self.init
			self.write_bytes([4, 8], file)
			self.convert_to_file(value, file)
		end

		def self.write_int(value, file)
			if value == 0 then
				self.write_byte(0, file)
			elsif value.between?(1, 123) then
				self.write_byte(value + 5, file)
			elsif value.between?(-123, -1) then
				self.write_byte(256 - 5 + value, file)
			else
				byte_count = nil
				bytes = nil

				# Determine byte number and create bit string
				if value > 0 then
					byte_count = (Math::log2(value + 1) / 8).ceil.to_i
					self.write_byte(byte_count, file)
					bytes = value.to_s(2)
				else
					byte_count = (Math::log2(-value) / 8).ceil.to_i
					self.write_byte(256 - byte_count, file)
					bytes = (256**byte_count + value).to_s(2)
				end

				# Fill up missing zeroes
				bytes = bytes.rjust(8*byte_count, "0")

				# Split string into 8-bit portions
				byte_array = []
				0.upto(byte_count - 1) do |i|
					byte_array[i] = bytes[i*8 .. (i + 1)*8 - 1].to_i(2)
				end

				# Put bytes in correct Marshalling order
				byte_array.reverse.each do |byte|
					self.write_byte(byte, file)
				end
			end
		end

		def self.write_raw_string(value, file)
			self.write_int(value.length, file)
			value.bytes.each do |byte|
				self.write_byte(byte, file)
			end
		end

		def self.convert_to_file(value, file)
			type = value.class

			if type == NilClass then
				self.write_byte(INDICATOR_NIL, file)

			elsif type == TrueClass then
				self.write_byte(INDICATOR_TRUE, file)

			elsif type == FalseClass then
				self.write_byte(INDICATOR_FALSE, file)

			elsif type == Fixnum then
				self.write_byte(INDICATOR_INT, file)
				self.write_int(value, file)

			elsif type == Float then
				self.write_byte(INDICATOR_FLOAT, file)
				float_string = value.to_s
				self.write_int(float_string.length)
				self.write_raw_string(float_string)

			elsif type == Array then
				self.write_byte(INDICATOR_ARRAY, file)
				self.write_int(value.length, file)

				value.each do |element|
					self.convert_to_file(element, file)
				end

			elsif type == String then
				self.write_byte(INDICATOR_INSTANCE_VAR, file)
				self.write_byte(INDICATOR_STRING, file)
				self.write_raw_string(value, file)
				self.write_int(1, file)
				self.convert_to_file(:E, file)
				self.convert_to_file(false, file)

			elsif type == Hash then
				self.write_byte(INDICATOR_HASH, file)
				self.write_int(value.size, file)
				value.each do |key, content|
					self.convert_to_file(key, file)
					self.convert_to_file(content, file)
				end

			elsif type == Symbol then
				sym_index = self.get_symbol_index(value)
				if sym_index then
					self.write_byte(INDICATOR_SYMBOL_LINK, file)
					self.write_int(sym_index, file)
				else
					self.write_byte(INDICATOR_SYMBOL, file)
					self.add_symbol(value)
					self.write_raw_string(value.to_s, file)
				end

			elsif type.method_defined?(marshal_dump) then
				self.write_byte(INDICATOR_USER_MARSHAL)
				self.convert_to_file(value.class.to_sym)
				self.convert_to_file(value.marshal_dump)

			else
				puts "Writing of #{type} class object #{value} not yet supported."
				raise "Writing of #{type} class object #{value} not yet supported."
			end
		end

		def self.interpret(file)
			indicator = self.read_byte(file)

			if indicator == INDICATOR_NIL then
				return nil

			elsif indicator == INDICATOR_TRUE then
				return true

			elsif indicator == INDICATOR_FALSE then
				return false

			elsif indicator == INDICATOR_INT then
				value = self.read_integer(file)

				return value

			elsif indicator == INDICATOR_FLOAT then
				length = self.interpret(file)

				result = self.read_bytes(file, length).to_f

				return result

			elsif indicator == INDICATOR_INSTANCE_VAR then
				obj = self.interpret(file)

				length = self.read_integer(file)

				has_encoding = true if obj.is_a?(String)

				0.upto(length - 1) do |i|
					name = self.interpret(file)
					value = self.interpret(file)

					if has_encoding then
						# TODO: Maybe an encoding check
					else
						obj.instance_variable_set("@#{name}", value)
					end
				end

				return obj

			elsif indicator == INDICATOR_STRING then
				length = self.read_integer(file)

				# NOTE: May not work properly with weird characters
				result = self.read_bytes(file, length).pack("U*")

				return result

			elsif indicator == INDICATOR_SYMBOL then
				length = self.read_integer(file)

				result = self.read_bytes(file, length).pack("U*").to_sym

				self.add_symbol(result)

				return result

			elsif indicator == INDICATOR_SYMBOL_LINK then
				index = self.read_integer(file)

				return self.ref_symbol(index)

			elsif indicator == INDICATOR_ARRAY then
				length = self.read_integer(file)

				final_array = Array.new(length)

				0.upto(length - 1) do |i|
					final_array[i] = self.interpret(file)
				end

				return final_array

			elsif indicator == INDICATOR_HASH then
				length = self.read_integer(file)

				final_hash = {}

				0.upto(length - 1) do |i|
					index = self.interpret(file)
					value = self.interpret(file)

					final_hash[index] = value
				end

				return final_hash

			elsif indicator == INDICATOR_USER_MARSHAL then
				# User-defined marshal_dump and marshal_load
				symbol = self.interpret(file)

				# Allocate new object of given class and initialize it using marshal_load
				marshalled_object = self.interpret(file)
				klass = Kernel.const_get(symbol)
				new_object = klass.allocate
				new_object.marshal_load(marshalled_object)

				return new_object

			else
				puts "Not implemented yet: Indicator #{indicator.chr} (#{indicator})"
				other_bytes = file.read(100)
				puts "Next 100 bytes: " + other_bytes.bytes.inspect
				puts "Next 100 chars: " + other_bytes.chars.inspect
				puts "Terminating execution..."
				raise "Terminated Marshal loading due to unknown indicator #{indicator.chr} (#{indicator})"

			end
		end

	end
end