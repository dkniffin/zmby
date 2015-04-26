require_relative 'movable'
require_relative 'item'

class Character < Movable
	attr_accessor :current_health, :max_health, :image
	attr_reader :inventory, :name
	INVENTORY_SIZE = 20

	def initialize(name, image, *args)
		super
		@inventory = []
		@max_health = 100
		@current_health = 100
		@name = name

		@image = image
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
			@inventory << new_item
		end
	end

	def drop(item_name, amount)
		amount = amount.to_i

		@inventory.each_with_index do |item, i|
			if item.name == item_name.downcase
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

	#in_inventory? will search across the player's inventory, and check if
	# the player has "amount" of "item_name". This will search across
	# multiple stacks.
	def in_inventory?(item_name, amount=1)
		total_amount = 0
		@inventory.each do |item|
			if item.name == item_name.downcase
				total_amount += item.count
				if total_amount >= amount
					puts "true"
					return true
				end
			end
		end
		puts "false"
		false
	end
end
