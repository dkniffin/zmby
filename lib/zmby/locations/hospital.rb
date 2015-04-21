class Hospital < Location
	def initialize
		super
		@search_chance[:medical_supplies] = 0.8
		@combat_chance = 0.5
	end
end
