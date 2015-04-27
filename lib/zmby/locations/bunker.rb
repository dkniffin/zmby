class Bunker < Location
	def initialize
		@max_supply = {:food => 25, :medicine => 25}
		super
	end
end
