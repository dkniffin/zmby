class Hospital < Location
	def initialize
		super
		@search_chance[:medical_supplies] = 0.8
	end
end