require 'zmby/movable'
require 'zmby/item'

class Character < Movable
	attr_accessor :current_health, :max_health, :medicine, :food, :ammo, :gas, :scrap
	attr_reader :inventory, :name
	INVENTORY_SIZE = 20

	def initialize(name, *args)
		super
		@inventory = []
		@max_health = 100
		@current_health = 100
		@name = name

		#General Resources
		@medicine = 0
		@food = 0
		@ammo = 0
		@gas = 0
		@scrap = 0
	end

	def health
		"#{@current_health} / #{@max_health}"
	end

	def heal(val)
		@current_health += val
	end

	def hurt(val)
		@current_health -= val
	end

	def take(new_item)
		@inventory.each do |item|
			if item.name == new_item.name && !item.capped?
				leftover = item.add_amount(new_item.count)
				if leftover
					new_item.set_amount(leftover)
					break
				else
					return
				end
			end
		end

		if @inventory.length < INVENTORY_SIZE
			@inventory << newItem
		end
	end

	def drop(item_name, amount)
		amount = amount.to_i

		@inventory.each_with_index do |item, i|
			if item.name == item_name
				amount = @inventory[i].remove_amount(amount)
				if @inventory[i].count == 0
					@inventory.delete_at(i)
					# Recursion is necessary, since when we
					# delete an element, we mess up the for loop.
					# Will refactor so that it is more readable.
					drop(item_name, amount)
				end
				if !amount
					break
				end
			end
		end
	end
end
