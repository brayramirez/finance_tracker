class UsersController < ApplicationController

  before_filter :get_user


  def edit
  end


  def update
    if @user.update_with_password user_params
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages
      render :edit
    end
  end



private

  def get_user
    @user = current_user
  end


  def user_params
    params.require(:user).permit(:name, :password,
      :password_confirmation, :current_password)
  end

end