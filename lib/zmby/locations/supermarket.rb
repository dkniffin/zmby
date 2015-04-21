class Supermarket < Location
	def initialize
		super
		@search_chance[:food] = 0.9
		@combat_chance = 0.01
	end
end
