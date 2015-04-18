class Woods < Location
	def initialize
		super
		@supply = rand(50..100)
		@search_chance[:materials] = 1
		@combat_chance = 0.3
	end
	def search
		@supply -= 10
		# TODO: return materials
	end
end
