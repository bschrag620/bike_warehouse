class Manufacturer < ApplicationRecord
	has_many :frames
	has_many :bikes, through: :frames

	validates :name, presence: true, uniqueness: true
end
