class Admin::DisciplinesController < Admin::BaseController
	def index
		@disciplines = Discipline.all
	end

	def new
		@discipline = Discipline.new
	end

	def create
		@discipline = Discipline.create(discipline_params)

		if @discipline.save
			redirect_to admin_base_new_path
		else
			render :edit
		end
	end

	def edit
		@discipline = Discipline.find(params[:id])
	end

	def show
		@discipline = Discipline.find(params[:id])
	end

	def update
		@discipline = Discipline.find(params[:id])

		@discipline.update(discipline_params)
		if @discipline.save
			flash[:message] = "Discpline updated."
			redirect_to admin_disciplines_path
		else
			render :edit
		end
	end	

	def destroy

	end

	private
	def discipline_params
		params.require(:discipline).permit(:name)
	end
end