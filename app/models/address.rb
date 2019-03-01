class Address < ApplicationRecord
	validates :line_1, :city, :state, :zip, presence: true
	validates :zip, numericality: {integer_only: true}

	belongs_to :user
	has_many :purchase_addresses
	has_many :purchases, through: :purchase_addresses
end
