class Woods < Location
	def initialize
		super
		@supply = rand(50..100)
		@search_chance[:scrap] = 1
		@combat_chance = 0.2
	end
	def search
		if @supply > 10
			@supply -= 1
			# TODO: return materials
			ItemFactory.instance.createItem(:scrap)
		end
	end
end
