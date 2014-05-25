class LineItemsController < ApplicationController

  layout false


  before_filter :get_daily_record, :only => [:new, :create]
  before_filter :get_line_item, :only => [:edit, :update, :destroy]


  def show
    @line_item = @daily_record.line_items.find params[:id]
  end


  def new
    @line_item = @daily_record.line_items.new
  end


  def create
    @line_item = @daily_record.line_items.new line_item_params

    if @line_item.save
      respond_to do |format|
        format.js
      end
    else
      render 'new'
    end
  end


  def edit
  end


  def update
    if @line_item.update_attributes line_item_params
      respond_to do |format|
        format.js
      end
    else
      render 'edit'
    end
  end


  def destroy
    @line_item.destroy

    redirect_to @line_item.daily_record
  end



private

  def get_daily_record
    @daily_record = DailyRecord.find params[:daily_record_id]
  end


  def get_line_item
    @line_item = LineItem.find params[:id]
  end


  def line_item_params
    params.require(:line_item).
      permit(:description, :amount)
  end

end
