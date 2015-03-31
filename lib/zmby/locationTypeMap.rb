module LocationTypeMap
	@@two_way_map = {'H' => Hospital, '#' => Field}

	class << self
		def char2class(char)
			@@two_way_map[char]
		end
		def class2char(cls)
			@@two_way_map.invert[cls]
		end
	end
end
