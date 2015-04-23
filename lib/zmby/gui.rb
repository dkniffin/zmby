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

			# Draw character in the middle of screen
			@char_draw_x = (@window_width / 2) - 32
			@char_draw_y = (@window_height / 2) - 32

			# UI
			@top_bar_image = Gosu::Image.new(self, "assets/ui/top_bar.png")
			@font = Gosu::Font.new(self, Gosu::default_font_name, 20)

			@wood_image = Gosu::Image.new(self, "assets/ui/wood.png")
			@water_image = Gosu::Image.new(self, "assets/ui/water_bottle.png")
			@gas_image = Gosu::Image.new(self, "assets/ui/gas_can.png")
			@medkits_image = Gosu::Image.new(self, "assets/ui/medkit.png")
			@ammo_image = Gosu::Image.new(self, "assets/ui/ammo.png")
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
			when Gosu::KbS
				@game.search
			when Gosu::KbF
				@game.fortify
			when Gosu::KbH
				@game.heal
			when Gosu::KbI
				@game.inventory
			end
		end

		def draw
			player = @game.current_player
			offset = {
				:x => (player.x * 64) - @char_draw_x,
				:y => (player.y * 64) - @char_draw_y
			}

			# Map
			@game.map.draw(offset[:x], offset[:y])

			# Other players
			@game.players.select{|p| p != player}.each do |p|
				p.image.draw(p.x*64 - offset[:x], p.y*64 - offset[:y],20)
			end

			# Current character image
			player.image.draw(@char_draw_x,@char_draw_y,20)

			# UI
			@top_bar_image.draw(0,5,100)

			ui_text_color = Gosu::Color::argb(0xff8A0707)
			draw_resources([[@wood_image, player.scrap],
						 [@water_image, player.food],
						 [@gas_image, player.gas],
						 [@medkits_image, player.medicine],
						 [@ammo_image, player.ammo]
						], 20, ui_text_color)

			player_indicator_str = "Player: #{player.name}"
			str_width = player_indicator_str.length * 10
			@font.draw(player_indicator_str, @window_width - (str_width + 5), 10, 101, 1.0, 1.0, ui_text_color)
		end

		def draw_resources(resources,start_pos,text_color)
			ui_x = start_pos
			resources.each do |img,count|
				img.draw(ui_x,8,100)
				ui_x += img.width + 5
				@font.draw("#{count}", ui_x, 10, 101, 1.0, 1.0, text_color)
				ui_x += 30
			end
		end
	end
end
