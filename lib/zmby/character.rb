module Zmby
	class Character
		attr_accessor :current_health, :max_health
		attr_reader :x, :y	#x and y should be moved to the Moveable class.

		def initialize(*args)
			@max_health = 100
			@current_health = 100
			@x = 4
			@y = 2
		end

		def health
			"#{@current_health} / #{@max_health}"
		end

		def heal(val)
			@current_health += val
		end

		def hurt(val)
			@current_health -= val
		end
	end
end