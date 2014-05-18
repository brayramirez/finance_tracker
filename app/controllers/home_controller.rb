class HomeController < ApplicationController

	def show
		cutoff = current_user.cutoffs.include Date.today

		if cutoff
			redirect_to cutoff
		else
			redirect_to [:new, :cutoff]
		end
	end

end
