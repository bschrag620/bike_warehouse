class Address < ApplicationRecord
	validates :line_1, :city, :state, :zip, presence: true
	validates :zip, numericality: {integer_only: true}

	belongs_to :user
end
