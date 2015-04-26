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

	#item_name is the name of the Item's classname that you want.
	#amount is the stack number of the item.
	#instances is the number of copies of the item you want.
	#Example: createItem("Ammo", 20, 3) will create 3 ammo objects, with 20 bullets in each.
	def createItems(item_name, amount=1, instances=1)

		new_items = []

		instances.times do

			case item_name.downcase
			# Stackable resources.
			when "medicine"
				new_items.push(Medicine.new(amount))
			when "food"
				new_items.push(Food.new(amount))
			when "ammo"
				new_items.push(Ammo.new(amount))
			when "gas"
				new_items.push(Gas.new(amount))
			when "scrap"
				new_items.push(Scrap.new(amount))

			# Weapons.
			when "knife"
				new_items.push(Knife.new(amount))
			when "pistol"
				new_items.push(Pistol.new(amount))

			# Tools.

			# Miscellaneous Items.

			# Otherwise, error.
			else
				puts "Could not create item(s): #{item_name}."
				break
			end
		end

		new_items
	end
end
