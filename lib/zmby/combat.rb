require_relative 'enemy'

class Combat
  def self.fight(current_player)
    enemy = Enemy.new
    puts "An average zombie hears your footsteps! It attacks!"
    while enemy.health > 0
      puts "Your Health: #{current_player.health} -  Enemy Health: #{enemy.health}"
    
      # Determines damage from each enemy per turn
      player_damage = rand(current_player.class::DAMAGE_RANGE) + current_player.damage_bonus
      enemy_damage = rand(enemy.class::DAMAGE_RANGE)

      current_player.hurt(enemy_damage)   
      enemy.hurt(player_damage)
    end
  end
end
