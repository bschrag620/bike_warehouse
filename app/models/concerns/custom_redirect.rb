module CustomRedirect
	extend ActiveSupport::Concern
	
	included do
		def set_redirect(link)
			session[:redirect] = link
		end

		def redirect?
			!session[:redirect].nil?
		end

		def clear_redirect
			session.delete(:redirect)
		end
	end
end