class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include CustomRedirect

  	def order_table_by(table, cat, direction)
		table.order("#{cat} #{direction}")
	end
end
