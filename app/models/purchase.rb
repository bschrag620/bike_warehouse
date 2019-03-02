class Purchase < ApplicationRecord
	belongs_to :shipping_address
	belongs_to :billing_address
	belongs_to :user

	has_many :bikes
end