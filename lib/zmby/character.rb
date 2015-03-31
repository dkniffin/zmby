require 'zmby/movable'
module Zmby
	class Character < Movable
		attr_accessor :current_health, :max_health

		def initialize(*args)
			super
			@max_health = 100
			@current_health = 100
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