require 'singleton'

require_relative 'character'
require_relative 'map'
require_relative 'itemFactory'
require_relative 'combat'

class Game
	include Singleton

	START_MOVES = 4

	attr_reader :map, :current_player, :players
	def initialize
		@current_player = nil
		@actions = START_MOVES
		@map = nil
		@players = []
	end

	# Game state functions
	def new_game(window, map)
		load_map(window, map)
		create_characters(window)
	end
	def load_game(window, map)
		# TODO: Load game data from somewhere
	end

	def save_game
		# TODO: Save game data somewhere
	end


	# Commands
	def move(direction)
		out = move_player(direction)
		action
		out
	end
	def drive(direction)
		# TODO: Check for vehicle
		out = move_player(direction,2)
		action
		out
	end

	def health
		@current_player.health
	end
	alias_method :hp, :health

	def heal
		@current_player.heal(10)
		action
		@current_player.health
	end

	def eat
		@current_player.eat
	end

	# def map
	# 	@map.render(@current_player.x,@current_player.y)
	# end
	def coords
		get_position
	end

	def inventory
		inv = @current_player.inventory
		if inv.count == 0 then puts "Inventory is empty."
		else
			for item in inv
				puts item.class.name + ": " + item.count.to_s
			end
		end
		return
	end

	def search
		items = @map.get_location_of(@current_player).search
		puts "Found: "
		pp items
		items.each{|i|@current_player.take(i)}
		action
	end

	def fortify(scrap_usage=5)
		#Guard condition: The player lacks a hammer.
		if !@current_player.in_inventory?("hammer")
			puts "You don't have a hammer!"
			return
		end

		#Guard condition: The player lacks the necessary scrap.
		if !@current_player.in_inventory?("scrap", scrap_usage)
			puts "You don't have enough scrap!"
			return
		end

		current_location = @map.get_location_of(@current_player)
		@current_player.drop("scrap", scrap_usage)
		current_location.fort_level += scrap_usage

		if (currentLocation.fort_level >= 100)
			victory_end(@current_player.name)
		else
			action
			"You fortified your location. It's fortifcation level is now #{current_location.fort_level}"
		end
	end

	# Testing function.
	def drop(item_name, amount)
		@current_player.drop(item_name, amount)
	end

	# Testing function.
	def create_items(item_name, amount=1)
		#Instantiate the ItemFactory.
		factory = ItemFactory.instance
		#Create the desired items.
		new_items = factory.createItems(item_name, amount)
		for item in new_items
			@current_player.take(item)
		end
	end

	private

		def notify
			for player in @players
				player.update
			end
		end

		def get_position
			"#{@current_player.x}, #{@current_player.y}"
		end

		def get_next_player
			new_player_index = (@players.index(@current_player) + 1) % @players.count
			@players[new_player_index]
		end

		def action
			@actions -= 1
			@current_player.get_hungry
			random_event
			if @actions.zero?
				new_turn
			else
				puts "You have #{@actions} actions left"
			end
		end

		def new_turn
			@current_player = get_next_player
			print "It's now #{@current_player.name}'s turn \n"
			@actions = START_MOVES
		end

		def random_event
			if @map.get_location_of(@current_player).combat?
				Combat.fight(@current_player)
			end
		end

		def move_player(direction,speed=1)
			case direction
			when 'up','u','n','north'
				@current_player.y -= 1
			when 'down','d','s','south'
				@current_player.y += 1
			when 'left','l','w','west'
				@current_player.x -= 1
			when 'right','r','e','east'
				@current_player.x += 1
			end
			self.coords
		end

		def create_characters(window)
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
				image = Gosu::Image.new(window, "assets/characters/#{i}.png")
				@players.push(Character.new(gets.chomp,image))
			end

			#Set the current_player to the first player.
			@current_player = @players.first

			#Debug stuff.
			# puts "Players in Players array: "
			# for player in @players
			# 	puts player.name
			# end
			# puts "Current player: " + @current_player.name
			return
		end

		# Given a file name, load the map
		def load_map(window,map)
			@map = Map.new(window, JSON.load(File.open(map)), File.dirname(map))
		end

		def victory_end(winning_player)
			puts "#{winning_player} has established a base of operations. We win!"
			# TODO: End the game, I don't actually know how.
		end
end


