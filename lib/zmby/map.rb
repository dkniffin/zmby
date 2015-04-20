require 'gosu_tiled'
require 'zmby/locationFactory'

require 'pp'
class Map < Gosu::Tiled::Map
	def initialize(window, data, datadir)
		super
		@locations = []
		load_locations
	end

	# Reads the tiled objects to make a grid of locations
	def load_locations
		w = @data['width']
		h = @data['height']
		xi_max = w/2 - 1
		yi_max = h/2 - 1

		objects = @layers.object.first.data["objects"]

		(0..yi_max).each do |yi|
			@locations[yi] = []
			(0..xi_max).each do |xi|
				x = (xi) * @data['tilewidth']*2
				y = (yi) * @data['tilewidth']*2
				i_objs = objects.select{|o| o['x'] == x && o['y'] == y}
				type = nil
				case i_objs.length
				when 0
					type = 'woods'
				when 1
					type = i_objs.first['type']
				else
					puts "ERROR: (#{xi},#{yi}) has more than one object"
				end
				@locations[yi][xi] = LocationFactory.instance.build_location(type)
			end
		end
	end

	def ascii
		tmp = {
			'woods' => '#',
			'road' => '.',
			'house' => 'A',
			'hospital' => 'H',
			'warehouse' => 'W',
			'office' => 'O',
			'store' => 'S',
			'gas_station' => 'G',
			'prison' => 'P'
		}
		char_ary = @locations.map {|row| row.map {|loc| tmp[loc] }}
		char_ary.map{|a|a.join(' ')}.join("\n")
	end

	def load(filename)
		factory = LocationFactory.instance

		File.open(filename,"r") do |f|
			f.each_line do |line|
				chars = line.gsub(/\s+/, "").chars

				row = chars.map do |char|
					factory.build_location(char)
				end
				@map.push(row)
			end
		end
	end
	def get_location(x,y)
		@locations[y][x]
	end
	def get_location_of(movable)
		get_location(movable.x,movable.y)
	end
end
