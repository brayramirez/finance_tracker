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
	belongs_to :category


	after_save :refresh_record





	private

	# TODO: Move to Helper/Form
	def refresh_record
		self.daily_record.update_attributes :expenses => total_expenses
	end


	def total_expenses
		self.daily_record.line_items.sum :amount
	end

end
