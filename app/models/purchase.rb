class Purchase < ApplicationRecord
	belongs_to :shipping_address
	belongs_to :billing_address
	belongs_to :user

	before_validation :create_purchase_id

	validates :shipping_address_id, presence: true
	validates :billing_address_id, presence: true
	validates :cc_number, numericality: {only_integer: true}, allow_nil: true
	has_many :bikes


	def mark_as_complete(subtotal, tax)
		self.in_process = false
		self.completed = true
		self.subtotal = subtotal
		self.tax = tax
		self.total = self.subtotal + self.tax
		self.save
	end	

	private
	def create_purchase_id
		self.purchase_id = (Time.now.to_f * 1000).floor
	end
end