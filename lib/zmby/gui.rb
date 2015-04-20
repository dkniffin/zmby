require 'gosu'
require 'zmby/game'

module Zmby
	class GUI < Gosu::Window
		def initialize
			super(800, 600, false)
			@game = Game.instance
			# TODO: Menu screen w/ New Game, Load Game, Exit
			@game.new_game(self, "assets/2.json")

			@x = @y = 0
			@speed = 3
		end

		def update
			@x -= @speed if button_down?(Gosu::KbLeft)
			@x += @speed if button_down?(Gosu::KbRight)
			@y -= @speed if button_down?(Gosu::KbUp)
			@y += @speed if button_down?(Gosu::KbDown)
		end

		def draw
			@game.map.draw(@x, @y)
			# TODO: Draw character on map
		end
	end
end
