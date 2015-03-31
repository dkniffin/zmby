module LocationTypeMap
	@@two_way_map = {
		'H' => Hospital,
		'#' => Woods,
		'.' => Road,
		'A' => House, # Because it looks like roof. ish.
		'O' => Office,
		'P' => Prison,
		'G' => GasStation,
		'S' => Supermarket,
		'W' => Warehouse
		# TODO: Other possible locations:
		# Footpath
		# Bunker
		# Bridge
		# Tunnel
		# Sewer (teleport between them)
		# Parking Lot
		# Apartments
		# Hotel
		# Barn
	}

	module_function
		def char2class(char)
			@@two_way_map[char]
		end
		def class2char(cls)
			@@two_way_map.invert[cls]
		end
end
