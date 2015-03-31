require 'zmby/movable'
require 'zmby/item'
module Zmby
	class Character < Movable
		attr_accessor :current_health, :max_health
		attr_reader :inventory

		def initialize(*args)
			super
			@inventory = []
			@max_health = 100
			@current_health = 100
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

		def pickUp(itemName, amount=1)
			amount = amount.to_i
			#Get a list of names of items in the inventory.
			itemNames = @inventory.map(&:name)

			#Do we already have that item in the array?
			if i = itemNames.index(itemName)
				#Increase that item's count. 
				@inventory[i].addAmount(amount)
			else
				#Add a new item to inventory.
				@inventory << Zmby::Item.new(itemName, amount)
			end
		end

		def drop(itemName, amount)
			amount = amount.to_i
			#Get a list of names of items in the inventory.
			itemNames = @inventory.map(&:name)

			#Do we have that item in the array?
			if i = itemNames.index(itemName)
				#Subtract amount.
				@inventory[i].removeAmount(amount)

				#Check if we no longer have any amount of that item.
				if @inventory[i].count == 0
					#Remove the item from the list.
					@inventory.delete_at(i)
				end
			end
		end
	end
end