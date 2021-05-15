# Classes for specialized shapes.
# There are two different types of shapes which are used in this engine.
# It is of course possible, to extend them, but their implementation needs to be done specifically.

module SDC

	class Actionshape

		attr_accessor :active, :shape_index, :attributes

		def initialize(active: true, shape_index: nil, attributes: {})
			@active = active
			@shape_index = shape_index
			@attributes = attributes
		end

		def initialize_copy(other)
			super(other)
			@attributes = other.attributes.dup
		end

	end

	# Hitshapes are shapes which are able to inflict damage or other conditions

	class Hitshape < Actionshape

		attr_accessor :damage

		def initialize(active: true, shape_index: nil, damage: 0, attributes: {})
			super(active: active, shape_index: shape_index, attributes: attributes)
			@damage = damage
		end

	end

	# Hurtshapes are receptors for damage and interactions

	class Hurtshape < Actionshape

		def initialize(active: true, shape_index: nil, attributes: {})
			super(active: active, shape_index: shape_index, attributes: attributes)
		end

	end

end