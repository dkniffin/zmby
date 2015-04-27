class House < Location
	def initialize
		@max_supply = {:food => 50, :medicine => 30, :ammo => 10}
		@combat_chance = 0.01
		super
	end
end
