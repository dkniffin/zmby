class Woods < Location
	def initialize
		super
		@supply = rand(50..100)
		@search_chance[:materials] = 1
		@combat_chance = 0.2
	end
	def search
		if @supply > 10
			@supply -= 10
			# TODO: return materials
			puts "Got 10 Materials"
		end
	end
end
