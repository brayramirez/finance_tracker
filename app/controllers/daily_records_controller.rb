class DailyRecordsController < ApplicationController

	before_filter :get_cutoff, :only => [:new, :create]
	before_filter :get_daily_record, :except => [:new, :create]


	def show
	end


	def new
		@daily_record = DailyRecord.new
	end


	def create
		@daily_record = @cutoff.daily_records.new daily_record_params

		if @daily_record.save
			redirect_to @daily_record
		else
			raise @daily_record.errors.inspect
			render :new
		end
	end


	def edit
	end


	def update
		if @daily_record.update_attributes daily_record_params
			redirect_to @daily_record
		else
			render :edit
		end
	end


	def destroy
		@daily_record.destroy
		redirect_to @daily_record.cutoff
	end



private

	def get_cutoff
		@cutoff = Cutoff.find_by_id params[:cutoff_id]
	end


	def get_daily_record
		@daily_record = DailyRecord.find_by_id params[:id]
	end

	def daily_record_params
		params.require(:daily_record).permit :transaction_date,
			:budget, :notes
	end

end