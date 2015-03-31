class Prison < Location
	def initialize
		super
		@search_chance[:weapons] = 0.4
		@search_chance[:medical_supplies] = 0.2
	end
end
