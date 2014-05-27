# == Schema Information
#
# Table name: line_items
#
#  id              :integer          not null, primary key
#  description     :text
#  amount          :decimal(10, 2)   default(0.0)
#  daily_record_id :integer
#  category_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class LineItem < ActiveRecord::Base

	belongs_to :daily_record


	after_save :refresh_daily_record
	


private

	def refresh_daily_record
		self.daily_record.update_attributes(
			:expenses => compute_total_expense)
	end


	def compute_total_expense
		self.daily_record.line_items.sum :amount
	end

end
