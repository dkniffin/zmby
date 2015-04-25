require 'singleton'

#base Item and Weapon
require_relative 'item'
require_relative 'items/weapon'

#Child Item classes
require_relative 'items/ammo'
require_relative 'items/food'
require_relative 'items/gas'
require_relative 'items/medicine'
require_relative 'items/scrap'

#Child Weapon classes
require_relative 'items/weapons/pistol'
require_relative 'items/weapons/knife'


# Use this factory to create every item you need in the game.

class ItemFactory
	include Singleton

	def createItem(item_name, amount=1)
		case item_name
		# Stackable resources.
		when "Medicine"
			Medicine.new(amount)
		when "Food"
			Food.new(amount)
		when "Ammo"
			Ammo.new(amount)
		when "Gas"
			Gas.new(amount)
		when "Scrap"
			Scrap.new(amount)

		# Weapons.
		when "Knife"
			Knife.new(amount)
		when "Pistol"
			Pistol.new(amount)

		# Tools.

		# Miscellaneous Items.

		# Otherwise, error.
		else
			puts "Could not create item: #{item_name}."
		end
	end
end
