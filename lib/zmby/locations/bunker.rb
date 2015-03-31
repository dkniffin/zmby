class Bunker < Location
	def initialize
		super
		@search_chance[:weapons] = 0.5
		@search_chance[:food] = 0.3
		@search_chance[:medical_supplies] = 0.3
	end
end
