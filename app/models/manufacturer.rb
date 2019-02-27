class Manufacturer < ApplicationRecord
	has_many :frames

	validates :name, presence: true, uniqueness: true
end
