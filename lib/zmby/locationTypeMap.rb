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
		# Church
	}

	module_function
		def char_to_class(char)
			@@two_way_map[char]
		end
		def class_to_char(cls)
			@@two_way_map.invert[cls]
		end
end
