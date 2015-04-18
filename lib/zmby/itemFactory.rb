require 'singleton'

#base Item and Weapon
require 'zmby/item'
require 'zmby/items/weapon'

#Child Item classes
require 'zmby/items/ammo'
require 'zmby/items/food'
require 'zmby/items/gas'
require 'zmby/items/medicine'
require 'zmby/items/scrap'

#Child Weapon classes
require 'zmby/items/weapons/pistol'
require 'zmby/items/weapons/knife'


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
