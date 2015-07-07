class HomeController < ApplicationController

	def show
    path = current_user.cutoffs.current || [:new, :cutoff]

		redirect_to path
	end

end
