module SDCMeta
	module ClassProperty

		def define_class_property(symbol, default: nil)
			define_singleton_method(symbol) do
				val = instance_variable_get("@#{symbol}")
				if val then
					return val
				else
					val = default
					return default
				end
			end

			define_singleton_method("#{symbol}=") do |value|
				instance_variable_set("@#{symbol}", value)
			end

			attr_accessor(symbol)

			define_method("#{symbol}") do
				val = instance_variable_get("@#{symbol}")
				if val then
					return val
				else
					val = self.class.send(symbol)
					return val
				end
			end
		end

	end

	module Property

		def define_property(symbol, default: nil)
			define_method("#{symbol}") do
				val = instance_variable_get("@#{symbol}")
				if val then
					return val
				else
					val = default
					return default
				end
			end
			
			define_method("#{symbol}=") do |value|
				instance_variable_set("@#{symbol}", value)
			end

		end

	end
end