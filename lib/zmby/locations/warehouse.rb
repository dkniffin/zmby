class Warehouse < Location
	def initialize
		@max_supply = {:scrap => 40}
		super
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
