class Office < Location
	def initialize
		@max_supply = {:medicine => 20, :food => 20}
		@combat_chance = 0.05
		super
	end
end
