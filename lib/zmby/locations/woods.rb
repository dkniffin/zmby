class Woods < Location
	def initialize
		@max_supply = {:scrap => 70}
		@combat_chance = 0.2
		super
	end
	def search
		if @current_supply[:scrap] > 10
			@current_supply[:scrap] -= 3
			# TODO: return materials
			ItemFactory.instance.createItems("scrap",3)
		end
	end
end
