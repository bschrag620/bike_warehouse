class Bike < ApplicationRecord

	def self.all_(category)
		Bike.all.pluck(category)
	end
end
