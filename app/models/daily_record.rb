# == Schema Information
#
# Table name: daily_records
#
#  id               :integer          not null, primary key
#  notes            :text
#  transaction_date :date
#  budget           :decimal(10, 2)   default(0.0)
#  expenses         :decimal(10, 2)   default(0.0)
#  cutoff_id        :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class DailyRecord < ActiveRecord::Base

	belongs_to :cutoff

	has_many :line_items, :dependent => :destroy


	scope :latest, -> { order("transaction_date DESC") }


	def to_s
		self.transaction_date.strftime('%B %-d, %Y')
	end

end
