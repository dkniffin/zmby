class Location
	attr_accessor :fort_level
	@@MAX_SUPPLY = {}
	def initialize
		# Setup max
		@current_supply = @@MAX_SUPPLY.reduce({}){|item,count| hash.merge(item => count*rand(0.8..1.0)) }

		@weapon_chance = {
			:knife => 0.1,
			:pistol => 0.1
		}
		@fort_level = 0
		@combat_chance = 0
	end
	def char
		LocationTypeMap.class_to_char(self.class)
	end
	def search
		@current_supply.each do |t,p|
			if rand < p
				ItemFactory.createItems(p.to_s,)
			end
		end
	end

	def combat?
		(rand < @combat_chance)
	end
end
