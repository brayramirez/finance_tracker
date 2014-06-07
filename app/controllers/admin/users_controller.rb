class Admin::UsersController < Admin::BaseController

  before_filter :get_user, :only => [:edit, :update, :destroy]


  def index
    @users = User.all
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new user_params

    if @user.save
      redirect_to [:admin, :users]
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end


  def edit
  end


  def update
    if @user.update_attributes user_params
      redirect_to [:admin, :users]
    else
      flash[:alert] = @user.errors.full_messages
      render :edit
    end
  end


  def destroy
    @user.destroy
    redirect_to [:admin, :users]
  end



private

  def get_user
    @user = User.find params[:id]
  end


  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

end