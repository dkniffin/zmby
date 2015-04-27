require_relative 'movable'
require_relative 'item'

class Character < Movable
	attr_accessor :current_health, :max_health, :image, :current_hunger, :max_hunger
	attr_reader :inventory, :name
	INVENTORY_SIZE = 20
	HUNGER_TICK = 2

	def initialize(name, image, *args)
		super
		@inventory = []
		@max_health = 100
		@current_health = 100
		@max_hunger = 100
		@current_hunger = 100
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

	def hunger
		"#{@current_hunger} / #{@max_hunger}"
	end

	def get_hungry(val=HUNGER_TICK)
		#get more hungry.
		if current_hunger > 0
			@current_hunger -= val.to_i
			#set to 0 if we are past it.
			if @current_hunger < 0
				@current_hunger = 0
			end
		#if we are starving, decrease health.
		else
			hurt(5)
		end
	end

	def eat
		if in_inventory?("food")
			drop("food", 1)
			@current_hunger += 10
		else
			puts "You have no food to eat!"
		end
	end


	def inventory_count(item_name)
		@inventory.select{|i| i.name == item_name}.map{|i| i.count}.reduce(:+) || 0
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
					return true
				end
			end
		end
		false
	end
end
