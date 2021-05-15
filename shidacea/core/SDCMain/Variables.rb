module SDC

	def self.get_variable(index, default: nil)
		return @game.get_variable(index, default: default)
	end

	def self.set_variable(index, value)
		@game.set_variable(index, value)
	end

	def self.get_switch(index)
		return @game.get_switch(index)
	end

	def self.set_switch(index, value: true)
		@game.set_switch(index, value: value)
	end

	def self.reset_switch(index, value: false)
		@game.set_switch(index, value: value)
	end

	def self.toggle_switch(index)
		@game.toggle_switch(index)
	end

	def self.increase_variable(index, value = 1, default: 0)
		@game.increase_variable(index, value, default: default)
	end

	def self.decrease_variable(index, value = 1, default: 0)
		@game.decrease_variable(index, value, default: default)
	end

	def self.multiply_variable(index, value, default: 0)
		@game.multiply_variable(index, value, default: default)
	end

end