module SDC
	module Debug

		def self.on_debug
			return if !SDC::Script.debug?
			yield
		end

		def self.on_release
			return if SDC::Script.debug?
			yield
		end

		def self.measure_time
			return nil if !SDC::Script.debug?
			t0 = Time.now
			yield
			return Time.now - t0
		end

		def self.log_time(msg)
			return if !SDC::Script.debug?
			t = self.measure_time do
				yield
			end
			self.log(msg.to_s + (t * 1000.0).to_s + " ms")
		end

		def self.log(message)
			return if !SDC::Script.debug?
			puts message
		end

	end
end