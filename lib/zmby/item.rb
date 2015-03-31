module Zmby
	class Item
		attr_reader :name, :count
		def initialize(itemName, initialCount=1)
			@name = itemName
			@count = initialCount
		end

		def addAmount(amount)
			@count += amount
		end

		def removeAmount(amount)
			@count -= amount
			if(@count < 0) 
				@count = 0
			end
		end
	end
end