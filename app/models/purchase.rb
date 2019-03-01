class Purchase < ApplicationRecord
	has_many :purchase_addresses
	has_many :addresses, through: :purchase_addresses

	has_many :bikes
end