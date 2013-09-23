class LineItemsController < ApplicationController

  layout false


  before_filter :get_daily_record


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
    @line_item = @daily_record.line_items.find params[:id]
  end


  def update
    @line_item = @daily_record.line_items.find params[:id]

    if @line_item.update_attributes line_item_params
      respond_to do |format|
        format.js
      end
    else
      render 'edit'
    end
  end


  def destroy
    @line_item = @daily_record.line_items.find params[:id]
    @line_item.destroy

    redirect_to @daily_record
  end



private

  def get_daily_record
    @daily_record = DailyRecord.find params[:daily_record_id]
  end


  def line_item_params
    params.require(:line_item).
      permit(:description, :amount)
  end

end
