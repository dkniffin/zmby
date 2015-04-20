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

	def build_location(type)
		case type
		when 'hospital'
			Hospital.new
		when 'woods'
			Woods.new
		when 'road'
			Road.new
		when 'house'
			House.new
		when 'office'
			Office.new
		when 'prison'
			Prison.new
		when 'gas_station'
			GasStation.new
		when 'store'
			Supermarket.new
		when 'warehouse'
			Warehouse.new
		else
			puts "ERROR: Unknown type #{type}"
		end
	end
end
