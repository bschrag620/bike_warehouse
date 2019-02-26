class Discipline < ApplicationRecord
	has_many :frame_disciplines
	has_many :frames, through: :frame_disciplines

	def self.mass_create(names)
		names.split(' ').collect do |name|
			self.find_or_create_by(:name => name).id
		end
	end
end
