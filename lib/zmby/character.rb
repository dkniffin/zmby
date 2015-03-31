require 'zmby/movable'
require 'zmby/item'

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
		# TODO: Limit the number of items a person can carry
		amount = amount.to_i

		added = false
		@inventory.each do |item|
			# TODO: Encapsulate this into the item class (see drop as well)
			# If the names match
			if item.class.name.downcase == itemName.downcase
				item.addAmount(amount)
				added = true
				break
			end
		end
		if !added
			# TODO: Don't create a new item, but rather look in the
			# current location and pull from there.
			@inventory << Item.new(amount)
		end
	end

	def drop(itemName, amount)
		amount = amount.to_i

		removed = false
		@inventory.each_with_index do |item,i|
			# If the names match
			if item.class.name.downcase == itemName.downcase
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
