require 'singleton'

require 'zmby/character'
require 'zmby/map'

module Zmby
	class Game
		include Singleton

		DEFAULTMOVES = 4

		def initialize
			@currentPlayer = Zmby::Character.new
			@actions = DEFAULTMOVES
			@map = nil
		end

		# Commands
		def move(direction)
			"Moving #{direction}"
		end

		def health
			@currentPlayer.health
		end
		alias_method :hp, :health

		def heal
			@currentPlayer.heal(10)
			@currentPlayer.health
		end

		def new_game(map)
			@map = Map.new(map)
		end
		def map
			@map.to_s
		end

		private
			def getPosition
				puts @currentPlayer.x, @currentPlayer.y
			end

			def newTurn(nextPlayer)
				@currentPlayer = nextPlayer
				@actions = DEFAULTMOVES
			end
	end
end

