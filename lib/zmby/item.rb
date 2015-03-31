module Zmby
	class Item
		attr_reader :count
		def initialize(count=1)
			@count = count
			@maxAmount = 1
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
		def name
			self.class.name.downcase
		end
	end
end