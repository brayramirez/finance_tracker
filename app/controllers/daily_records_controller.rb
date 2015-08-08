class DailyRecordsController < BaseController

  before_filter :init_cutoff, :only => [:new, :create]
  before_filter :init_daily_record, :only => [:show, :edit, :update, :destroy]
  before_filter :init_new_daily_record, :only => [:create]
  before_filter :init_form, :only => [:create, :edit, :update]
  before_filter :init_new_line_item, :only => [:show]
  before_filter :init_line_item_form, :only => [:show]


  def create
    if @form.validate params[:daily_record]
      @form.save

      flash[:success] = 'Record successfully created.'
      redirect_to @daily_record
    else
      flash[:error] = @form.errors.full_messages
      render 'cutoffs/show'
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


  def init_new_line_item
    @line_item = @daily_record.line_items.build
  end


  def init_line_item_form
    @form = LineItemForm.new @line_item
  end

end
