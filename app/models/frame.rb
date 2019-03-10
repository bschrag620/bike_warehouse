class Frame < ApplicationRecord
	belongs_to :manufacturer

	has_many :frame_disciplines
	has_many :disciplines, through: :frame_disciplines
	has_many :reviews

	validates :name, presence: true, uniqueness: true

	def self.sort_by_manufacturer
		Frame.joins(:manufacturer).order("manufacturers.name ASC")
	end

	def manufacturer_name
		self.manufacturer.name
	end

	def rating
		Frame.joins(:reviews).where("reviews.frame_id = ?", self.id).average("reviews.rating").to_f.round(1)
	end

	def self.excluding_manufacturer(manufacturer)
		joins(:manufacturer).where.not("manufacturers.name = ?", manufacturer.name)
	end

	def full_name
		"#{self.manufacturer_name} #{self.name}"
	end

	def total_count
		Bike.all.where("frame_id = ?", self.id).count
	end

	def discipline_names
		self.disciplines.pluck(:name).join(', ')
	end
end
