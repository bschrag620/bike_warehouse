class Bike < ApplicationRecord
	belongs_to :frame
	belongs_to :purchase, optional: true
	has_many :reviews

	before_validation :set_serial
	after_validation :set_part_number
	after_update :set_part_number

	validates :serial, :frame_id, :size, :components, :price, :color, :year, presence: :true
	validates :price, :size, :year, numericality: {integer_only: true}


	def self.unique_bikes
		Bike.group("part_number")
	end

	def self.find_available(pn)
		where("part_number = ? AND is_available = ?", pn, true).first
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

	def mark_in_cart
		self.in_cart = true
		self.is_available = false
		self.sold = false
		self.save
	end

	def mark_as_sold(purchase_id)
		self.in_cart = false
		self.is_available = false
		self.sold = true
		self.purchase_id = purchase_id
		self.save
	end

	def mark_available
		self.in_cart = false
		self.is_available = true
		self.sold = false
		self.save
	end	

	def self.frame_match(frame_name)
		joins(:frame).where("frames.name = ?", frame_name)
	end

	def self.discipline_match(disc_name)
		 joins(frame: :disciplines).where("disciplines.name = ?", disc_name)
	end

	def self.manufacturer_match(man_name)
		joins(frame: :manufacturer).where("manufacturers.name = ?",man_name)
	end

	def self.order_by_manufacturer(direction)
		joins(frame: :manufacturer).order("manufacturers.name #{direction}")
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

	def self.order_by_quantity(direction)
		select("*, count(*) as total_count").group("part_number").order("total_count #{direction}")
	end

	def self.ordered_by(category, direction="asc")
		category_symbol = "order_by_#{category}".to_sym
		category_method = Bike.method(category_symbol)
		category_method.call(direction)
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
		self.frame.discipline_names
	end	

	def status
		if self.is_available
			"Available"
		elsif self.in_cart
			"In cart"
		else
			"Sold"
		end
	end

	def rating
		ratings = self.reviews.pluck(:rating)
		if ratings.size == 0
			0
		else
			ratings.sum.to_f / ratings.size || 0
		end
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
