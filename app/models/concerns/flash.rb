module Flash
	extend ActiveSupport::Concern

	included do
		def flash_update(text)
			flash[:message] = "#{text} updated."
		end

		def flash_create(text)
			flash[:message] = "#{text} created."
		end

		def flash_destroy(text)
			flash[:message] = "#{text} removed from database."
		end

		def flash_custom(text)
			flash[:message] = text
		end
	end
end