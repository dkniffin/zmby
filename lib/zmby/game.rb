require 'singleton'

require 'zmby/character'
require 'zmby/map'
require 'zmby/itemFactory'

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
		action
	end
	def drive(direction)
		# TODO: Check for vehicle
		movePlayer(direction,2)
		action
	end

	def health
		@currentPlayer.health
	end
	alias_method :hp, :health

	def heal
		@currentPlayer.heal(10)
		@currentPlayer.health
		action
	end

	def new_game(map="maps/1.txt")
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
				puts item.class.name + ": " + item.count.to_s
			end
		end
		return
	end

	def search
		@map.getLocation(@currentPlayer.x,@currentPlayer.y).search
		action
	end
	
	def fortify(scrap_usage = 0)
		if (scrapusage <= 0) 
			puts "Need to put in some scrap to fortify!"
			return
		end
		if (scrapusage > @currentPlayer.Scrap)
			puts "You don't have that much scrap!"
			return
		end
		
		currentLocation = @map.getPlace(@currentPlayer.x, @currentPlayer.y)
		@currentPlayer.Scrap -= scrap_usage
		currentLocation.fort_level += scrap_usage
		puts "You fortified your location. It's fortifcation level is now" + currentLocation.fort_level
		if (currentLocation.fort_level >= 100)
			VictoryEnd(@currentPlayer)
		end
		action
		
	end
	
	def VictoryEnd(winning_player)
		puts winning_player + "finally established a base of operations. We win!"
		#End the game, I don't actually know how.

	# Testing function.
	def drop(itemName, amount)
		@currentPlayer.drop(itemName, amount)
	end

	# Testing function.
	def create_item(itemName, amount=1)
		#Instantiate the ItemFactory.
		itemFactory = ItemFactory.instance
		#Create the desired item.
		newItem = itemFactory.createItem(itemName, amount)
		@currentPlayer.take(newItem)
	end

	private
		def getPosition
			"#{@currentPlayer.x}, #{@currentPlayer.y}"
		end

		def getNextPlayer
			new_player_index = (@players.index(@currentPlayer) + 1) % @players.count
			@players[new_player_index]
		end

		def action
			@actions -= 1
			if @actions.zero?
				newTurn
			else
				puts "You have #{@actions} actions left"
			end
		end

		def newTurn
			@currentPlayer = getNextPlayer
			print "It's now #{@currentPlayer.name}'s turn \n"
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


