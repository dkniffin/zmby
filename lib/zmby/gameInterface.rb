require 'singleton'

require 'zmby/game'

class GameInterface
	include Singleton

	def initialize
		@game = Zmby::Game.instance
	end

	def handleCommand(input)
		# Parse input into parts
		args = input.split
		command = args.shift.to_sym # First argument is the command

		# Grab all Game's methods
		methods = @game.public_methods

		if ! methods.include? command
			"Error: Unknown Command: #{command}"
		else
			@game.send(command,*args)
		end

	end
end