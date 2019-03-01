class Bike < ApplicationRecord
	belongs_to :frame
	belongs_to :purchase


	before_validation :set_serial
	after_validation :set_part_number
	after_update :set_part_number

	validates :serial, :frame_id, :size, :components, :price, :color, :year, presence: :true
	validates :price, :size, :year, numericality: {integer_only: true}


	def self.all_(category)
		Bike.all.pluck(category).uniq
	end

	def self.unique_bikes
		bikes = Bike.select("part_number").distinct
		bikes.collect do |bike|
			Bike.find_by(:part_number => bike.part_number)
		end
	end

	def exact_match
		Bike.where("part_number = ?", self.part_number)
	end

	def qty_available
		exact_match.where("is_available = ?", true).count
	end

	def qty_sold
		exact_match.where("is_sold = ?", true).count
	end

	def return_by_part_number(pn)
		Bike.find_by(:part_number => pn)
	end

	def mark_in_cart
		self.in_cart = true
		self.is_available = false
		self.sold = false
		self.save
	end

	def mark_as_sold
		self.in_cart = false
		self.is_available = false
		self.sold = true
		self.save
	end

	def mark_available
		self.in_cart = false
		self.is_available = true
		self.sold = false
		self.save
	end	
	
	#def self.order_by(category, direction = "asc")
	#	full_name = 'order_by_' + category
	#	method(full_name.to_sym).call(direction)
	#end

	def self.by_discipline(discipline_name)
		discipline = Discipline.find_by(:name => discipline_name)
		if discipline
			joins(frame: :frame_disciplines).where("discipline_id = ?", discipline.id)
		end
	end

	def self.frame_match(frame_name)
		Bike.joins(:frame).where("frames.name = ?", frame_name)
	end

	def self.manufacturer_match(man_name)
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

	def discipline_names
		self.frame.disciplines.pluck(:name).join(', ')
	end	

	private
	def set_serial
		if self.serial.nil?
			self.serial = (Time.now.to_f * 1000).floor
		end
	end

	def set_part_number
		self.part_number = "#{self.year.to_s[-2..-1]}#{self.manufacturer_name[0..3].upcase}-#{self.frame_name[0..2].upcase}-#{self.size}-#{self.components[0..2].upcase}-#{self.color[0..2].upcase}"
	end
end
