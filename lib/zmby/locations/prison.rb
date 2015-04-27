class Prison < Location
	def initialize
		@max_supply = {:medicine => 20}
		@combat_chance = 0.6
		super
	end
end
