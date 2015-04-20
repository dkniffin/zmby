require 'gosu'
require 'gosu_tiled'
require 'zmby/game'

module Zmby
	class GUI < Gosu::Window
		def initialize
			super(800, 600, false)
			@game = Game.instance
			load_map
			# @menu_image = Gosu::Image.new(self, "media/Space.png", true)
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
			@map.draw(@x, @y)
		end

		def load_map
			@map = Gosu::Tiled.load_json(self, 'assets/2.json')
		end
	end
end
