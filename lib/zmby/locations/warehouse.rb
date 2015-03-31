class Warehouse < Location
	def initialize
		super
		@search_chance[:materials] = 0.4
	end
end