class Bike < ApplicationRecord
	belongs_to :frame
	belongs_to :purchase, optional: true

	has_one :manufacturer, through: :frame
	
	has_many :reviews, through: :frame
	has_many :disciplines, through: :frame

	before_validation :set_serial
	after_validation :set_part_number
	after_update :set_part_number

	validates :serial, :frame_id, :size, :components, :price, :color, :year, presence: :true
	validates :price, :size, :year, numericality: {integer_only: true}

	scope :by_part_numbers, -> {
		group(:part_number)
	}

	scope :order_by_components, ->(dir) {
		by_part_numbers.order("components #{dir}")
	}

	scope :order_by_price, ->(dir) {
		by_part_numbers.order("price #{dir}")
	}

	scope :order_by_color, ->(dir) {
		by_part_numbers.order("color #{dir}")
	}

	scope :order_by_size, ->(dir) {
		by_part_numbers.order("size #{dir}")
	}

	def self.all_(category)
		Bike.all.pluck(category).uniq
	end

	def self.unique_bikes
		group("part_number, bikes.id")
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
		joins(frame: :manufacturer).group("part_number, manufacturers.name").order("manufacturers.name #{direction}")
	end

	def self.order_by_frame(direction)
		joins(:frame).group("part_number, frames.name").order("frames.name #{direction}")
	end

	def self.order_by_rating(direction)
		left_joins(frame: :reviews).group("part_number").select("bikes.*, avg(reviews.rating) as rating").order("rating #{direction}")
	end

	def self.order_by_quantity(direction)
		select("*, sum(is_available::int) as total_count").group("part_number, bikes.id").order("total_count #{direction}")
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
		self.frame.rating
	end

	def set_serial
		if self.serial.nil?
			self.serial = (Time.now.to_f * 1000).floor
		end
	end

	def set_part_number
		self.part_number = "#{self.year.to_s[-2..-1]}#{self.manufacturer_name[0..3].upcase}-#{self.frame_name[0..2].upcase}-#{self.size}-#{self.components[0..2].upcase}-#{self.color[0..2].upcase}"
	end

end
