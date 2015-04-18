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
	def render(x,y)
		char_ary = @map.map {|row| row.map {|loc| loc.char }}
		char_ary[y][x] = '!'
		ascii = char_ary.map{|a|a.join(' ')}.join("\n")
		ascii += "\n"
		ascii += ""
	end
	def getLocation(x,y)
		@map[y][x]
	end
	def getPlayerLocation(player)
		@map[player.y][player.x]
	end
end
