class Discipline < ApplicationRecord
	has_many :bike_disciplines
	has_many :bikes, through: :bike_disciplines

	def self.mass_create(names)
		names.split(' ').collect do |name|
			self.find_or_create_by(:name => name).id
		end
	end
end
