module Zmby
	class Character
		attr_accessor :current_health, :max_health

		def initialize(*args)
			@max_health = 100
			@current_health = 100
		end

		def health
			"#{@current_health} / #{@max_health}"
		end
	end
end