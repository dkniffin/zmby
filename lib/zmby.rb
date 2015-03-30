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
new  - Create a new game
load - Load an existing game

At any point, you can type "help" to get a list of commands you can run.

eoc

			puts entryText

			loop do
				$stdout.print(prompt)
				input = gets.chomp

				output = game.handleCommand(input)
			  	puts output
			end
		end
	end
end
