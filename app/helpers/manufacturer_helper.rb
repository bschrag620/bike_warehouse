module ManufacturerHelper
	def other_manufacturers(man)
		if man.id.nil?
			Frame.sort_by_manufacturer
		else
			Frame.excluding_manufacturer(man).order("manufacturers.name ASC")
		end
	end

	def deletable?(frame, man)
		if frame_total_count(frame.name) == 0
			link_to("Delete", admin_frame_path(frame, :redirect => edit_admin_manufacturer_path(man)), :method => 'delete')
		end
	end

	def frame_total_count(name)
		Bike.frame_match(name).count
	end

	def link_to_admin_or_user(man)
		if is_admin?
	    	link_to(man.name, edit_admin_manufacturer_path(man))
		else
			link_to(man.name, manufacturer_bikes_path(man))
		end
	end
end