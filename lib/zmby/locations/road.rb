class Road < Location
	def initialize
		@max_supply = {:gas => 50}
		@combat_chance = 0.15
		super
	end
end
