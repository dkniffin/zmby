require "zmby/version"
require 'zmby/character'

module Zmby
	class << self
		def run
			player = Zmby::Character.new

			prompt = '> '

			loop do
			  $stdout.print(prompt)
			  input = gets.chomp
			  case input
			  when /health/,/hp/
			  	puts player.health
			  when 'exit'
			  	exit 0
			  else
			  	puts 'Invalid command'
			  end
			end
		end
	end
end
