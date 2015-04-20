require 'singleton'

require 'pp'
require 'zmby/game'

module Zmby
	class CLI
		include Singleton

		def initialize
			@game = Game.instance
		end

		def run
			prompt = '> '

			entryText = <<-eoc
Hello there!

Welcome to Zmby, a text-based zombie survival game.

== Insert story text ==

From here you can run:
new_game <file>  - Create a new game
load_game <file> - Load an existing game

At any point, you can type "help" to get a list of commands you can run.

eoc

			puts entryText

			loop do
				$stdout.print(prompt)
				input = $stdin.gets.chomp

				output = handle_command(input)
		  		puts output
			end
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
end
