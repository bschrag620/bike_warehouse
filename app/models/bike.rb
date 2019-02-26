class Bike < ApplicationRecord
	belongs_to :frame


	before_validation :set_serial

	validates :serial, :frame_id, :size, :components, :price, :color, :year, presence: :true
	validates :price, :size, :year, numericality: {integer_only: true}

	def frame_name=(name)
		frame = Frame.find_or_create_by(name)
		self.frame_id = frame.id
	end

	def self.all_(category)
		Bike.all.pluck(category).uniq
	end

	def self.order_by(category, direction = "asc")
		full_name = 'order_by_' + category
		method(full_name.to_sym).call(direction)
	end

	def self.by_discipline(discipline_name)
		discipline = Discipline.find_by(:name => discipline_name)
		if discipline
			joins(frame: :frame_disciplines).where("discipline_id = ?", discipline.id)
		end
	end

	def self.by_frame(frame_name)
		Bike.joins(:frame).where("frames.name = ?", frame_name)
	end

	def self.by_manufacturer(man_name)
		joins(frame: :manufacturer).where("manufacturers.name = ?",man_name)
	end

	def self.order_by_manufacturer(direction)
		Bike.joins(frame: :manufacturer).order("manufacturers.name #{direction}")
   
	end

	def self.order_by_frame(direction)
		joins(:frame).order("frames.name #{direction}")
	end

	def self.order_by_components(direction)
		order("components #{direction}")
	end

	def self.order_by_price(direction)
		order("price #{direction}")
	end

	def self.order_by_size(direction)
		order("size #{direction}")
	end

	def self.order_by_color(direction)
		order("color #{direction}")	
	end

	def set_serial
		if self.serial.nil?
			self.serial = (Time.now.to_f * 1000).floor
		end
	end

	def full_name
		"#{self.year} #{self.manufacturer_name} #{self.frame_name}"
	end

	def frame_name
		self.frame.name
	end

	def manufacturer
		self.frame.manufacturer
	end	

	def manufacturer_name
		self.manufacturer.name
	end

	def part_number
		"#{self.year.to_s[-2..-1]}#{self.manufacturer_name[0..3].upcase}-#{self.frame_name[0..2].upcase}-#{self.size}-#{self.components[0..2].upcase}-#{self.color[0..2].upcase}"
	end

	def discipline_names
		self.frame.disciplines.pluck(:name).join(', ')
	end	

	def match_by(attribute)
		v = self.send(attribute)
		Bike.where("#{attribute} = ?", "#{v}")
	end

	def exact_match
		Bike.where({ 
		:frame_id => self.frame_id,
		:size => self.size,
		:color => self.color,
		:components => self.components,
		:year => self.year
		})
	end
end
