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
			link_to("Delete", frame_path(frame, :redirect => edit_manufacturer_path(man)), :method => 'delete')
		end
	end

	def frame_total_count(name)
		Bike.by_frame(name).count
	end
end