require 'singleton'
require 'zmby/game'

class GameInterface
	include Singleton

	def initialize
		@game = Zmby::Game.instance
	end

	def handleCommand(input)
		case input
		when /health/,/hp/
			@game.getHealth
		when /(drive|move) (.*)/
			movementType = $1.to_sym
			direction = $2
			speed = 1
		when /search/
			puts "search the area"
		when /heal/
			@game.healPlayer(10)
			puts @player.health
		when /fortify/
			puts "fortify"
		when /give/
			puts "give resources"
		when /dropoff/
			puts "dropoff resources"
		when /pickup/
			puts "pickup resources"
		when 'exit'
			exit 0
		else
			puts 'Invalid command'
		end
	end
end