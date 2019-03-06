class DisciplinesController < ApplicationController
	def index
		@disciplines = Discipline.all
	end

	def edit
		@discipline = Discipline.find(params[:id])

	end

	def update

	end

	def destroy

	end
end