class Warehouse < Location
	def initialize
		super
		@supply = 50
		@search_chance[:scrap] = 0.4
		@combat_chance = 0.9
	end
	def search
		if @supply > 0
			@supply = 0
			ItemFactory.instance.createItem(:scrap)
			# TODO: return materials
		end
	end
end
