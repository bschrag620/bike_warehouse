class User < ApplicationRecord
	validates :username, presence: true, uniqueness: true
	validates :password_digest, confirmation: true, :if => :not_uid
	validates :password_digest_confirmation, presence: true, on: :create, :if => :not_uid
	validates :email, presence: true

	has_many :purchases
	has_many :shipping_addresses
	has_many :billing_addresses
	has_many :reviews

	accepts_nested_attributes_for :shipping_addresses
	accepts_nested_attributes_for :billing_addresses

	has_secure_password

	def address_to_symbol(text)
		"#{text}_addresses".to_sym
	end

	def default_address(address_type)
		address_symbol = address_to_symbol(address_type)
		address = self.send(address_symbol).where(:default => true)
		if address.empty?
			address = self.send(address_symbol).build(:default => true)
		else
			address = address[0]
		end
		address
	end

	def default_shipping
		self.default_address("shipping")
	end

	def default_billing
		self.default_address("billing")
	end

	def set_all_addresses_to_false_default(address_type)
		address_symbol = address_to_symbol(address_type)
		self.send(address_symbol).each do |address|
			address.default = false
			address.save
		end
	end

	def set_all_shipping_to_false
		self.set_all_addresses_to_false_default("shipping")
	end

	def set_all_billing_to_false
		self.set_all_addresses_to_false_default("billing")
	end

	private
	def not_uid
		!self.facebook_uid
	end
end
