class Office < Location
	def initialize
		super
		@search_chance[:medicine] = 0.2
		@search_chance[:food] = 0.2
		@combat_chance = 0.05
	end
end
