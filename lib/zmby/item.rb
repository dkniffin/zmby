class Item

	# Is there a way to do abstract classes in Ruby?
	# This class should never actually get instantiated.
	# Same with Weapon.

	# Also, the only way I found to override the parent STACKCAP
	# in the child class is by adding self.class::STACKCAP in the
	# parent class. Is there a better way to do this?

	attr_reader :count
	STACKCAP = 1
	DAMAGE_BONUS = 0

	def initialize(initial_count=1)
		initial_count = initial_count.to_i
		if initial_count > self.class::STACKCAP
			@count = self.class::STACKCAP
		else
			@count = initial_count
		end
	end

	def add_amount(amount)
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

	def remove_amount(amount)
		# Likewise, we return another leftover here too,
		# since if we have two stacks of 30 items each,
		# and we remove an amount of 40, we want to remove
		# 30 in a item instance, and remember we have 10
		# more to remove
		@count -= amount
		if @count < 0
			leftover = -@count
			@count = 0
			return leftover
		end
		return nil
	end

	def set_amount(amount)
		if amount > 0 && amount < self.class::STACKCAP
			@count = amount
		end
	end

	def damage_bonus
		self.class::DAMAGE_BONUS
	end
	def capped?
		return @count == self.class::STACKCAP
	end
	def name
		self.class.name.downcase
	end
end
