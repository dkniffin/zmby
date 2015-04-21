class Road < Location
	def initialize
		super
		@search_chance[:vehicles] = 0.7
		@search_chance[:gas] = 0.5
		@combat_chance = 0.15
	end
end
