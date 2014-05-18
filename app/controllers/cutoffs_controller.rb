class CutoffsController < ApplicationController

	before_filter :all_cutoffs, :except => [:destroy]
	before_filter :get_cutoff, :except => [:new, :create]


	def show
	end


	def new
		@cutoff = Cutoff.new
	end


	def create
		@cutoff = current_user.cutoffs.new cutoff_params

		if @cutoff.save
			redirect_to @cutoff
		else
			render :new
		end
	end


	def edit
	end


	def update
		if @cutoff.update_attributes cutoff_params
			redirect_to @cutoff
		else
			render :edit
		end
	end


	def destroy
		@cutoff.destroy
		redirect_to root_path
	end



private

	def get_cutoff
		@cutoff = current_user.cutoffs.find params[:id]
	end


	def all_cutoffs
		@cutoffs_list = current_user.cutoffs
	end


	def cutoff_params
		params.require(:cutoff).permit(:date_from, :date_to,
			:budget, :savings, :notes)
	end

end
