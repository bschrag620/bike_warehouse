class BillingAddress < ApplicationRecord
	belongs_to :user
	has_many :purchases

	validates :street_address_1, :city, :state, :zip, presence: true
	validates :zip, numericality: {integer_only: true}, length: {is: 5}

	include AddressConcerns
end