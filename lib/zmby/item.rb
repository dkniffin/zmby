module Zmby
	class Item
		attr_reader :name, :count, :maxAmount
		def initialize(itemName, initialCount=1, maxAmount=1)
			@name = itemName
			@count = initialCount
			@maxAmount = maxAmount
		end

		def addAmount(amount)
			@count += amount
			if @count > @maxAmount 
				@count = @maxAmount
			end
		end

		def removeAmount(amount)
			@count -= amount
			if @count < 0 
				@count = 0
			end
		end
	end
end