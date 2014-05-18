# == Schema Information
#
# Table name: line_items
#
#  id              :integer          not null, primary key
#  description     :text             default("0")
#  amount          :decimal(, )
#  daily_record_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class LineItem < ActiveRecord::Base

	belongs_to :daily_record

end
