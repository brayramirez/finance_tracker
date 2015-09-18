class CutoffsController < BaseController

  before_filter :init_selected_year, :only => [:index, :create]
  before_filter :init_cutoffs, :only => [:index, :create]
  before_filter :init_cutoff, :only => [:show, :edit, :update, :destroy]
  before_filter :init_new_cutoff, :only => [:index, :create]
  before_filter :init_form, :only => [:index, :create, :edit, :update]
  before_filter :init_new_daily_record, :only => [:show]
  before_filter :init_daily_record_form, :only => [:show]


  def index
  end


  def create
    if @form.validate params[:cutoff]
      @form.save

      flash[:success] = 'Cutoff successfully created.'
      redirect_to @form.model
    else
      flash[:error] = @form.errors.full_messages
      render :index
    end
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

    redirect_to [:root]
  end





  private

  def init_new_cutoff
    @cutoff = current_user.cutoffs.new
  end


  def init_cutoffs
    @cutoffs = current_user.cutoffs.latest
  end


  def init_cutoff
    @cutoff = current_user.cutoffs.find params[:id]
  end


  def init_form
    @form = CutoffForm.new @cutoff
  end


  def init_selected_year
    @selected_year = params[:year] || current_user.cutoffs.year_list.sort.last || Date.today.year

    redirect_to cutoffs_path(:year => @selected_year) if current_user.cutoffs.invalid_year?(current_user, @selected_year)
  end


  def init_new_daily_record
    @daily_record = @cutoff.daily_records.new
  end


  def init_daily_record_form
    @form = DailyRecordForm.new @daily_record
  end

end
