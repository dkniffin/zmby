require 'gosu'
require 'gosu_tiled'

class GameWindow < Gosu::Window
  def initialize
    super(800, 600, false)
    @map = Gosu::Tiled.load_json(self, 'assets/2.json')
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
end

GameWindow.new.show
