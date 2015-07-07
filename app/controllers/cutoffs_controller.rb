class CutoffsController < ApplicationController

	before_filter :init_user_cutoffs, :only => [:show]
	before_filter :init_cutoff, :only => [:show, :edit, :update, :destroy]


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

	def init_cutoff
		@cutoff = current_user.cutoffs.find params[:id]
	end


	def init_user_cutoffs
		@user_cutoffs = current_user.cutoffs
	end


	def cutoff_params
		params.require(:cutoff).permit :date_from, :date_to,
			:budget, :savings, :notes
	end

end
