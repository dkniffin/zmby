require 'zmby/movable'
require 'zmby/item'

class Character < Movable
	attr_accessor :current_health, :max_health
	attr_reader :inventory, :name
	INVENTORY_SIZE = 20

	def initialize(name, *args)
		super
		@inventory = []
		@max_health = 100
		@current_health = 100
		@name = name
		
		#General Resources
		@Medicine = 0
		@Food = 0
		@Ammo = 0 
		@Gas = 0 
		@Scrap = 0 
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

	def take(newItem)
		@inventory.each do |item|
			if item.name == newItem.name && !item.capped?
				leftover = item.addAmount(newItem.count)
				if leftover
					newItem.setAmount(leftover)
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

	def drop(itemName, amount)
		amount = amount.to_i

		@inventory.each_with_index do |item, i|
			if item.name == itemName
				amount = @inventory[i].removeAmount(amount)
				if @inventory[i].count == 0
					@inventory.delete_at(i)
					# Recursion is necessary, since when we 
					# delete an element, we mess up the for loop.
					# Will refactor so that it is more readable.
					drop(itemName, amount) 
				end
				if !amount
					break
				end
			end
		end
	end
end
