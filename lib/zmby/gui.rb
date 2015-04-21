require 'gosu'
require 'zmby/game'

module Zmby
	class GUI < Gosu::Window
		def initialize
			@window_width = 800
			@window_height = 600
			super(@window_width, @window_height, false)
			@game = Game.instance
			# TODO: Menu screen w/ New Game, Load Game, Exit
			@game.new_game(self, "assets/2.json")

			@char_image = Gosu::Image.new(self, "assets/character.png")
			# @x = @y = 0
			@speed = 3

			# Draw character in the middle of screen
			@char_draw_x = (@window_width / 2) - 32
			@char_draw_y = (@window_height / 2) - 32
		end

		def button_down(id)
			case id
			when Gosu::KbLeft
				@game.move('left')
			when Gosu::KbRight
				@game.move('right')
			when Gosu::KbUp
				@game.move('up')
			when Gosu::KbDown
				@game.move('down')
			end
		end

		def draw
			char = {
				:x => (@game.current_player.x * 64) - @char_draw_x,
				:y => (@game.current_player.y * 64) - @char_draw_y
			}

			@game.map.draw(char[:x], char[:y])
			@char_image.draw(@char_draw_x,@char_draw_y,20)
			# TODO: Draw character on map
			# @char_image.draw(char[:x],char[:y],20)

		end
	end
end
