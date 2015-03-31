class GasStation < Location
	def initialize
		super
		@supply = rand(50..100) # Gallons
		@search_chance[:gas] = 1
	end
	def search
		@supply -= 15
		# TODO: Return gas
	end
end
