class Item

	# Is there a way to do abstract classes in Ruby? 
	# This class should never actually get instantiated.
	# Same with Weapon.

	# Also, the only way I found to override the parent STACKCAP
	# in the child class is by adding self.class::STACKCAP in the
	# parent class. Is there a better way to do this?

	attr_reader :count
	STACKCAP = 1
	def initialize(initialCount=1)
		initialCount = initialCount.to_i
		if initialCount > self.class::STACKCAP
			@count = self.class::STACKCAP
		else
			@count = initialCount
		end
	end

	def addAmount(amount)
		# We return any leftover amount that wasn't able to be
		# stacked, so that we can have another item instance
		# with that amount. If there is no leftover, return
		# nil, this way, we can use boolean to take the
		# appropriate action.
		@count += amount
		if @count > self.class::STACKCAP
			leftover = @count - self.class::STACKCAP
			@count = self.class::STACKCAP
			return leftover
		end
		return nil
	end

	def removeAmount(amount)
		# Likewise, we return another leftover here too,
		# since if we have two stacks of 30 items each,
		# and we remove an amount of 40, we want to remove
		# 30 in a item instance, and remember we have 10
		# more to remove.
		@count -= amount
		if @count < 0
			leftover = -@count
			@count = 0
			return leftover
		end
		return nil
	end

	def setAmount(amount)
		if amount > 0 && amount < self.class::STACKCAP
			@count = amount
		end
	end

	def capped?
		return @count == self.class::STACKCAP
	end
	def name
		self.class.name.downcase
	end
end
