require 'singleton'

require_relative 'location'
require_relative 'locations/bunker'
require_relative 'locations/field'
require_relative 'locations/gas_station'
require_relative 'locations/hospital'
require_relative 'locations/house'
require_relative 'locations/office'
require_relative 'locations/prison'
require_relative 'locations/road'
require_relative 'locations/sporting_goods'
require_relative 'locations/supermarket'
require_relative 'locations/warehouse'
require_relative 'locations/woods'

require_relative 'locationTypeMap'


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
