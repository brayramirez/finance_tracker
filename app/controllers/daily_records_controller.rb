class DailyRecordsController < BaseController

  before_filter :init_cutoff, :only => [:new, :create]
  before_filter :init_daily_record, :only => [:show, :edit, :update, :destroy]
  before_filter :init_new_daily_record, :only => [:new, :create]
  before_filter :init_form, :only => [:new, :create, :edit, :update]


  def create
    if @form.validate params[:daily_record]
      @form.save

      flash[:success] = 'Record successfully created.'
      redirect_to @daily_record
    else
      flash[:error] = @form.errors.full_messages
      render :new
    end
  end


  def update
    if @form.validate params[:daily_record]
      @form.save

      flash[:success] = 'Record successfully updated.'
      redirect_to @daily_record
    else
      flash[:error] = @form.errors.full_messages
      render :edit
    end
  end


  def destroy
    DailyRecordDeleter.new(@daily_record).delete

    redirect_to @daily_record.cutoff
  end





  private

  def init_cutoff
    @cutoff = Cutoff.find_by_id params[:cutoff_id]
  end


  def init_daily_record
    @daily_record = DailyRecord.find_by_id params[:id]
  end


  def init_new_daily_record
    @daily_record = @cutoff.daily_records.new
  end


  def init_form
    @form = DailyRecordForm.new @daily_record
  end

end
