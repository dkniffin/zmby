require 'singleton'

module Zmby
	class Game
		include Singleton

		DEFAULTMOVES = 4

		def initialize
			@currentPlayer = Zmby::Character.new
			@actions = DEFAULTMOVES
		end

		def getPosition
			puts @currentPlayer.x, @currentPlayer.y
		end

		def getHealth
			@currentPlayer.heath
		end

		def HealPlayer(val)
			@currentPlayer.heal(val)
		end

		def newTurn(nextPlayer)
			@currentPlayer = nextPlayer
			@actions = DEFAULTMOVES
		end
	end
end

