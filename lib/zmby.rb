require "zmby/version"
require 'zmby/gameInterface'

module Zmby
	class << self
		def run

			game = GameInterface.instance

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
				input = gets.chomp

				output = game.handle_command(input)
		  		puts output
			end
		end
	end
end
