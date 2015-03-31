require 'singleton'

require 'zmby/location'
require 'zmby/locations/bunker'
require 'zmby/locations/field'
require 'zmby/locations/gas_station'
require 'zmby/locations/hospital'
require 'zmby/locations/house'
require 'zmby/locations/office'
require 'zmby/locations/prison'
require 'zmby/locations/road'
require 'zmby/locations/sporting_goods'
require 'zmby/locations/supermarket'
require 'zmby/locations/warehouse'
require 'zmby/locations/woods'

require 'zmby/locationTypeMap'


class LocationFactory
	include Singleton

	def initialize
	end

	def buildLocation(char)
		LocationTypeMap.char2class(char).new
	end
end
