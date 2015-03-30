require "zmby/version"
require 'zmby/character'

require 'zmby/gameInterface.rb'

module Zmby
	class << self
		def run

			game = GameInterface.instance

			prompt = '> '

			loop do
				$stdout.print(prompt)
				input = gets.chomp

				output = game.handleCommand(input)
			  	puts output
			end
		end
	end
end
