class LineItemsController < BaseController

  before_filter :init_daily_record, :only => [:new, :create]
  before_filter :init_line_item, :only => [:show, :edit, :update, :destroy]
  before_filter :init_new_line_item, :only => [:new, :create]
  before_filter :init_form, :only => [:new, :create, :edit, :update]


  def create
    if @form.validate params[:line_item]
      @form.save

      flash[:success] = 'Item successfully created.'
      redirect_to [@line_item.daily_record]
    else
      flash[:error] = @form.errors.full_messages
      render 'daily_records/show'
    end
  end


  def edit
  end


  def update
    if @form.validate params[:line_item]
      @form.save

      flash[:success] = 'Item successfully updated.'
      redirect_to [@line_item.daily_record]
    else
      flash[:error] = @form.errors.full_messages
      render :edit
    end
  end


  def destroy
    LineItemDeleter.new(@line_item).delete

    redirect_to @line_item.daily_record
  end





  private

  def init_daily_record
    @daily_record = DailyRecord.find params[:daily_record_id]
  end


  def init_line_item
    @line_item = LineItem.find params[:id]
  end


  def init_new_line_item
    @line_item = @daily_record.line_items.new
  end


  def init_form
    @form = LineItemForm.new @line_item
  end

end
