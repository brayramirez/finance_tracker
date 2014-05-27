class CategoriesController < ApplicationController

	before_filter :get_category, :only => [:show, :edit, :update]


	def index
		@categories = current_user.categories
	end


	def show
	end


	def new
		@category = current_user.categories.new
	end


	def create
		@category = current_user.categories.new category_params

		if @category.save
			redirect_to [:categories]
		else
			render :new
		end
	end


	def edit
	end


	def update
		if @category.update_attributes category_params
			redirect_to @category
		else
			render :edit
		end
	end


	def destroy
		@category.destroy
		redirect_to [:categories]
	end



private

	def get_category
		@category = current_user.categories.find params[:id]
	end


	def category_params
		params.require(:category).permit(:label)
	end

end
