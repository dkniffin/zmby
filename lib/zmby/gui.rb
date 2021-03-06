require 'gosu'
require_relative 'game'

module Zmby
	class GUI < Gosu::Window
		def initialize
			@window_width = 800
			@window_height = 600
			super(@window_width, @window_height, false)

			@main_menu_image = Gosu::Image.new(self,"assets/title.png")
			@cursor_image = Gosu::Image.new(self,"assets/ui/cursor.png")

			@in_game = false
			@game = Game.instance
			# TODO: Menu screen w/ New Game, Load Game, Exit

			# Draw character in the middle of screen
			@char_draw_x = (@window_width / 2) - 32
			@char_draw_y = (@window_height / 2) - 32

			# UI
			@top_bar_image = Gosu::Image.new(self, "assets/ui/top_bar.png")
			@font = Gosu::Font.new(self, Gosu::default_font_name, 20)

			@wood_image = Gosu::Image.new(self, "assets/ui/wood.png")
			@food_image = Gosu::Image.new(self, "assets/ui/food.png")
			@gas_image = Gosu::Image.new(self, "assets/ui/gas_can.png")
			@medkits_image = Gosu::Image.new(self, "assets/ui/medkit.png")
			@ammo_image = Gosu::Image.new(self, "assets/ui/ammo.png")

			@health_image = Gosu::Image.new(self, "assets/ui/health.png")
			@hunger_image = Gosu::Image.new(self, "assets/ui/hunger.png")
		end

		def button_down(id)
			if (@in_game)
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
				when Gosu::KbE
					@game.eat
				end
			else
				case id
				when Gosu::MsLeft
					if self.mouse_x > 290 && self.mouse_x < 500 &&
						self.mouse_y > 310 && self.mouse_y < 360
						# New game
						@game.new_game(self, "assets/2.json")
						@in_game = true

					elsif self.mouse_x > 290 && self.mouse_x < 500 &&
						self.mouse_y > 360 && self.mouse_y < 410
						# Quit game
						exit
					end
				end

			end
		end

		def draw
			@cursor_image.draw(self.mouse_x,self.mouse_y,9999)
			if (@in_game)
				draw_game
			else
				draw_main_menu
			end
		end

		def draw_main_menu
			@main_menu_image.draw(0,0,0)
		end

		def draw_game
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
			draw_resources([[@wood_image, player.inventory_count("scrap")],
						 [@food_image, player.inventory_count("food")],
						 [@gas_image, player.inventory_count("gas")],
						 [@medkits_image, player.inventory_count("medicine")],
						 [@ammo_image, player.inventory_count("ammo")]
						], 20, ui_text_color)

			# Current player
			player_indicator_str = "Player: #{player.name}"
			str_width = player_indicator_str.length * 10
			@font.draw(player_indicator_str, @window_width - (str_width + 5), 10, 101, 1.0, 1.0, ui_text_color)

			# Health bar
			@health_image.draw(5,40,99)
			draw_bar(30,40,100,20,
				Gosu::Color::GREEN,
				Gosu::Color::RED,
				@game.current_player.health_percent)

			# Hunger bar
			@hunger_image.draw(5,65,99)
			draw_bar(30,65,100,20,
				Gosu::Color::WHITE,
				Gosu::Color::GRAY,
				@game.current_player.hunger_percent)
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

		def draw_bar(x,y,width,height,full_color,empty_color,percent)
			full_w = percent * width
			bottom = y + height
			self.draw_quad(
				x,y,full_color,
				x + full_w,y,full_color,
				x + full_w,bottom,full_color,
				x,bottom,full_color,
				9999
				)
			self.draw_quad(
				x + full_w,y,empty_color,
				x + width,y,empty_color,
				x + width,bottom,empty_color,
				x + full_w,bottom,empty_color,
				9999
				)
		end
	end
end
