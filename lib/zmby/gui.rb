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

			# Character
			@char_image = Gosu::Image.new(self, "assets/character.png")

			# Draw character in the middle of screen
			@char_draw_x = (@window_width / 2) - 32
			@char_draw_y = (@window_height / 2) - 32

			# UI
			@top_bar_image = Gosu::Image.new(self, "assets/ui/top_bar.png")
			@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
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

			# Map
			@game.map.draw(char[:x], char[:y])

			# Character
			@char_image.draw(@char_draw_x,@char_draw_y,20)

			# UI
			@top_bar_image.draw(0,5,100)
			@font.draw("HP:#{@game.health}", 20, 10, 101, 1.0, 1.0, Gosu::Color::argb(0xffAA1717))

		end
	end
end
