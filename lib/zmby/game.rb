require 'singleton'

require 'zmby/character'
require 'zmby/map'

class Game
	include Singleton

	DEFAULTMOVES = 4

	def initialize
		@currentPlayer = nil
		@actions = DEFAULTMOVES
		@map = nil
		@players = []
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
		createCharacters()
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
			when 'up','u','n','north'
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

		def createCharacters()
			# Set up number of players.
			input = ""
			loop do
				puts "Enter the number of players (1-4):"
				input = gets
				break if(input =~ /1|2|3|4/)
				puts "Invalid input, please try again."
			end

			# Give players names.
			input = input.to_i
			(1..input).each do |i|
				puts "Enter Player #{i}'s name:"
				@players.push(Character.new(gets))
			end

			#Set the currentPlayer to the first player.
			@currentPlayer = @players.first

			#Debug stuff.
			# puts "Players in Players array: "
			# for player in @players
			# 	puts player.name
			# end
			# puts "Current player: " + @currentPlayer.name
			return
		end
end


