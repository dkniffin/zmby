class Supermarket < Location
	def initialize
		super
		@search_chance[:food] = 0.9
	end
end