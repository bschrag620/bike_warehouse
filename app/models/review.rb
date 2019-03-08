class Review < ApplicationRecord
	belongs_to :bike
	belongs_to :user

	validates :comment, :presence => true
	validates :rating, :numericality => {only_integer: true, greater_than: 0, less_thatn_or_equal_to: 10}
end
