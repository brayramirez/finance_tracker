class DailyRecordsController < ApplicationController

  before_filter :get_archive


  def index
    @selected_year = params[:year] || Date.today.year
    @selected_month = params[:month] || Date.today.month
    @daily_records = current_user.daily_records.
      find_by_year_and_month(@selected_year, @selected_month)
  end


  def show
    @daily_record = current_user.daily_records.find(params[:id]).decorate
    @selected_year = @daily_record.transaction_date.year
    @selected_month = @daily_record.transaction_date.month
    @selected_day = @daily_record.transaction_date.day
  end


  def new
    @daily_record = current_user.daily_records.new
  end


  def create
    @daily_record = current_user.daily_records.new daily_record_params

    if @daily_record.save
      redirect_to @daily_record
    else
      render 'new'
    end
  end


  def edit
    @daily_record = current_user.daily_records.find params[:id]
  end


  def update
    @daily_record = current_user.daily_records.find params[:id]

    if @daily_record.update_attributes(daily_record_params)
      redirect_to @daily_record
    else
      render 'edit'
    end
  end


  def destroy
    @daily_record = current_user.daily_records.find params[:id]
    @daily_record.destroy

    redirect_to daily_records_path
  end



private

  def get_archive
    @archive = current_user.daily_records.archive
  end


  def daily_record_params
    params.require(:daily_record).
      permit(:transaction_date, :budget, :notes)
  end

end
