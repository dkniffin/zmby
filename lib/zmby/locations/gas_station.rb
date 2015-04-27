class GasStation < Location
	def initialize
		@max_supply = {:gas => 100}
		@combat_chance = 0.1
		super
	end
	def search
		@supply -= 15
		# TODO: Return gas
	end
end
