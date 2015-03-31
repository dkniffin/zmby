require 'zmby/locationFactory'

class Map
	def initialize(filename)
		@map = []
		self.load(filename)
	end
	def load(filename)
		factory = LocationFactory.instance

		File.open(filename,"r") do |f|
			f.each_line do |line|
				chars = line.gsub(/\s+/, "").chars

				row = chars.map do |char|
					factory.buildLocation(char)
				end
				@map.push(row)
			end
		end
	end
	def to_s
		@map.map {|row| row.map {|loc| loc.char }.join(' ')}.join("\n")
	end
	def getPlace(x,y)
		@map[y][x]
	end
end