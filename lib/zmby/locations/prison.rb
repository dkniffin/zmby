class Prison < Location
	def initialize
		super
		@search_chance[:weapons] = 0.4
		@search_chance[:medical_supplies] = 0.2
		@combat_chance = 0.6
	end
end
