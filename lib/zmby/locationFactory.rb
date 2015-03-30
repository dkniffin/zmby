require 'singleton'

require 'zmby/location'
require 'zmby/locations/field'
require 'zmby/locations/hospital'

require 'zmby/locationTypeMap'


class LocationFactory
	include Singleton

	def initialize
	end

	def buildLocation(char)
		LocationTypeMap.char2class(char).new
	end
end