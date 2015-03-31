require 'singleton'

require 'zmby/character'
require 'zmby/map'

class Game
	include Singleton

	DEFAULTMOVES = 4

	def initialize
		@currentPlayer = Character.new
		@actions = DEFAULTMOVES
		@map = nil
	end

	# Commands
	def move(direction)
		movePlayer(direction)
	end
	def drive(direction)
		# TODO: Check for vehicle
		movePlayer(direction,2)
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
		@map.render(@currentPlayer.x,@currentPlayer.y)
	end
	def coords
		getPosition
	end

	def inventory
		inv = @currentPlayer.inventory
		if inv.count == 0 then puts "Inventory is empty."
		else
			for item in inv
				puts item.name + ": " + item.count.to_s
			end
		end
		return
	end

	def take(itemName, amount=1)
		@currentPlayer.pickUp(itemName, amount)
	end

	def drop(itemName, amount)
		@currentPlayer.drop(itemName, amount)
	end

	def search
		@map.getLocation(@currentPlayer.x,@currentPlayer.y).search
	end

	private
		def getPosition
			"#{@currentPlayer.x}, #{@currentPlayer.y}"
		end

		def newTurn(nextPlayer)
			@currentPlayer = nextPlayer
			@actions = DEFAULTMOVES
		end

		def movePlayer(direction,speed=1)
			case direction
			when 'up','r','n','north'
				@currentPlayer.y -= 1
			when 'down','d','s','south'
				@currentPlayer.y += 1
			when 'left','l','w','west'
				@currentPlayer.x -= 1
			when 'right','r','e','east'
				@currentPlayer.x += 1
			end
			self.coords
		end
end


