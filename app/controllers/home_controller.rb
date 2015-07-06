class HomeController < ApplicationController

	def show
    cutoff = current_user.cutoff.current
		# cutoff = current_user.cutoffs.include(Date.today) ||
		# 					current_user.cutoffs.last

		if cutoff
			redirect_to cutoff
		else
			redirect_to [:new, :cutoff]
		end
	end

end
