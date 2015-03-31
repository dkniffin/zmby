class Road < Location
	def initialize
		super
		@search_chance[:vehicles] = 0.7
		@search_chance[:gas] = 0.5
	end
end