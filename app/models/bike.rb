class Bike < ApplicationRecord
	has_many :bike_disciplines
	has_many :disciplines, through: :bike_disciplines

	def self.all_(category)
		Bike.all.pluck(category).uniq
	end

	def set_serial
		if self.serial.nil?
			self.serial = (Time.now.to_f * 1000).floor
		end
	end

	def full_name
		"#{self.year} #{self.manufacturer} #{self.frame}"
	end

	def part_number
		"#{self.year.to_s[-2..-1]}#{self.manufacturer[0..3].upcase}-#{self.frame[0..2].upcase}-#{self.size}-#{self.color[0..2].upcase}"
	end

	def discipline_names
		disciplines = ''
		self.disciplines.each do |d|
			disciplines += d.name + ', '
		end

		disciplines[0..-3]
	end	

	def match_by(attribute)
		v = self.send(attribute)
		Bike.where("#{attribute} = ?", "#{v}")
	end

	def exact_match
		Bike.where({ 
		:manufacturer => self.manufacturer,
		:frame => self.frame,
		:size => self.size,
		:color => self.color,
		:components => self.components,
		:year => self.year
		})
	end
end
