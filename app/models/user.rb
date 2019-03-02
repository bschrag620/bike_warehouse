class User < ApplicationRecord
	validates :username, presence: true, uniqueness: true
	validates :password, confirmation: true
	validates :password_confirmation, presence: true
	validates :email, presence: true

	has_many :purchases
	has_many :shipping_addresses
	has_many :billing_addresses

	accepts_nested_attributes_for :shipping_addresses
	accepts_nested_attributes_for :billing_addresses

	has_secure_password

	def get_addresses
		self.addresses.build(:address_type => "Shipping")
		self.addresses.build(:address_type => "Billing")
	end

	def has_shipping_address?(params)

	end
end
