class Location
	attr_accessor :fort_level
	def initialize
		# Setup max
		@max_supply ||= {}
		@fort_level ||= 0
		@combat_chance ||= 0
		@find_amount ||= 5

		setup_supply
	end

	def setup_supply
		@current_supply = @max_supply.reduce({}) do |hash,(item,count)|
			hash.merge(item => (count*rand(0.8..1.0)).ceil)
		end
	end

	def char
		LocationTypeMap.class_to_char(self.class)
	end
	def search
		@current_supply.keys.reduce([]) do |a,item|
			chance = @current_supply[item].to_f/@max_supply[item].to_f
			if rand < chance
				a.concat(ItemFactory.instance.createItems(item.to_s,@find_amount))
				@current_supply[item] -= @find_amount
			end
			a
		end
	end

	def combat?
		(rand < @combat_chance)
	end
end
