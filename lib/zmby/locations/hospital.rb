class Hospital < Location
	def initialize
		@max_supply = {:medicine => 80}
		@combat_chance = 0.5
		super
	end
end
