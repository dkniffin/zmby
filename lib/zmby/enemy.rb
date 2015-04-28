class Enemy

  attr_reader :health, :damage
  DAMAGE_RANGE = (1..2)
  def initialize
    @health = rand(0..50)
  end

  def hurt(val)
    @health -= val
  end
end