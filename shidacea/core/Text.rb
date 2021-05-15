module SDC

	class Text

		# Use these methods only if you want to treat outline and fill color as same
		
		def color=(value)
			self.outline_color = value
			self.fill_color = value
		end

		def color
			return self.fill_color
		end

	end

end
