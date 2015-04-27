class Supermarket < Location
	def initialize
		@max_supply = {:food => 100}
		@combat_chance = 0.01
		super
	end
end
