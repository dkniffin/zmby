class SportingGoodsStore < Location
	def initialize
		super
		@search_chance[:weapons] = 0.5
	end
end
