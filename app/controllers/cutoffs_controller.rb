class CutoffsController < ApplicationController

  before_filter :init_user_cutoffs, :only => [:show]
  before_filter :init_cutoff, :only => [:show, :edit, :update, :destroy]
  before_filter :init_new_cutoff, :only => [:new, :create]
  before_filter :init_form, :only => [:new, :create, :edit, :update]


  def show
  end


  def new
  end


  def create
    if @form.validate params[:cutoff]
      @form.save

      flash[:success] = 'Cutoff successfully created.'
      redirect_to @form.model
    else
      flash[:error] = @form.errors.full_messages
      render :new
    end
  end


  def edit
  end


  def update
    if @form.validate params[:cutoff]
      @form.save

      flash[:success] = 'Cutoff successfully updated.'
      redirect_to @form.model
    else
      flash[:error] = @form.errors.full_messages
      render :edit
    end
  end


  def destroy
    @cutoff.destroy

    redirect_to root_path
  end





  private

  def init_new_cutoff
    @cutoff = current_user.cutoffs.new
  end


  def init_cutoff
    @cutoff = current_user.cutoffs.find params[:id]
  end


  def init_form
    @form = CutoffForm.new @cutoff
  end


  def init_user_cutoffs
    @user_cutoffs = current_user.cutoffs
  end

end
