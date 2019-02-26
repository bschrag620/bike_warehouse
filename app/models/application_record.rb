class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  	def order_table_by(table, cat, direction)
		table.order("#{cat} #{direction}")
	end

	def hello_world
		puts "hey from application record"
	end
end
