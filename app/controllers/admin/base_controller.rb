class Admin::BaseController < ApplicationController

  before_filter :authorize_user!



private

  def authorize_user!
    raise ActionController::RoutingError.new('Not Found') if current_user.non_admin?
  end

end