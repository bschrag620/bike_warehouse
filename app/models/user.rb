class User < ApplicationRecord
	validates :username, presence: true, uniqueness: true
	validates :password, confirmation: true
	validates :password_confirmation, presence: true
	validates :email, presence: true
	has_many :addresses

	has_secure_password

	def default_shipping
		Address.new
	end

	def default_billing
		Address.new
	end
end
