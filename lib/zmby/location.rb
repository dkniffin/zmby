class Location
	def initialize
		@search_chance = {
			:medical_supplies => 0,
			:weapons => 0,
			:ammo => 0,
			:food => 0,
			:vehicles => 0,
			:gas => 0,
			:materials => 0
		}
		@fort_level = 0
		@combat_chance = 0
	end
	def char
		LocationTypeMap.class2char(self.class)
	end
	def search
		@search_chance.each do |t,p|
			if rand < p
				puts "Found #{t}"
			else
				puts "Did not find #{t}"
			end
		end
	end

	def combat?
		(rand < @combat_chance)
	end
end
