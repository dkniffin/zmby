require 'singleton'

require 'pp'
require 'zmby/game'

class GameInterface
	include Singleton

	def initialize
		@game = Game.instance
	end

	def handle_command(input)
		# Parse input into parts
		args = input.split
		command = args.shift.to_sym # First argument is the command

		# Grab all Game's methods
		methods = @game.public_methods(false)

		case command
		when :help
			methods.map do |m|
				m = @game.method(m)
				name = m.name
				required_params = m.parameters.select{|p| p[0] == :req}.map{|p| p[1]}
				optional_params = m.parameters.select{|p| p[0] == :opt}.map{|p| p[1]}

				string = "#{name}\n"
				if required_params.length > 0
					string += "  Required:\n"
					string += required_params.map{|p| "    #{p}\n" }.join
				end
				if optional_params.length > 0
					"  Optional:\n" +
					optional_params.map{|p| "    #{p}\n" }.join
				end
				string
			end.join
		when :quit, :q, :exit
			# TODO: Save prompt
			exit 0
		else
			if ! methods.include? command
				"Error: Unknown Command: #{command}"
			else
				@game.send(command,*args)
			end
		end

	end
end
