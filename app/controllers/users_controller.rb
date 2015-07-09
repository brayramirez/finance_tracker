class UsersController < ApplicationController

  before_filter :get_user


  def edit
  end


  def update
    flash[:alert] = nil

    if (password_present?(params[:user]) && @user.update_with_password(user_params)) ||
      (!password_present?(params[:user]) && @user.update(user_params))

      sign_in @user, :bypass => true
      flash[:notice] = 'Account updated successfully!'
      redirect_to [:edit, @user]
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
    if password_present? params[:user]
      params.require(:user).permit :name, :password,
        :password_confirmation, :current_password
    else
      params.require(:user).permit :name
    end
  end


  def password_present? params
    params[:password].present? || params[:password_confirmation].present?
  end

end
