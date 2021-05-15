# Utility class for the entity design in this project
# Nothing more than an extended container

# TODO: Replace this at some point with a hash-structure
# TODO: Generalize this for other applications

module SDC
	class SpecialContainer

		def initialize
			@values = []	
		end

		def add(element, index = nil)
			if index then
				@values[index] = element 
			else
				@values.push(element)
			end

			return @values.size
		end

		def get_all
			return @values
		end

		def get(index)
			return @values[index]
		end

		def size
			return @values.size
		end

	end
end