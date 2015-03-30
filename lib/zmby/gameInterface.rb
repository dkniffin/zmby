require 'singleton'

class GameInterface
	include Singleton

	def initialize
		@player = Zmby::Character.new
	end

	def handleCommand(input)
		case input
		when /health/,/hp/
			puts @player.health
		when /(drive|move) (.*)/
			movementType = $1.to_sym
			direction = $2
			speed = 1
		when /search/
			puts "search the area"
		when /heal/
			@player.heal(10)
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