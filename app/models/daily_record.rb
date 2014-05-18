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


	validates_presence_of :transaction_date
	validate :within_cutoff_dates


	def to_s
		s = "#{Date::MONTHNAMES[self.transaction_date.month]} "
		s += "#{self.transaction_date.day}, "
		s += "#{self.transaction_date.year}"

		s
	end



private

	def within_cutoff_dates
		if self.transaction_date && !self.cutoff.within_dates(self.transaction_date)
			errors.add(:transaction_date, 'Date should be within Cutoff Dates')
		end
	end
	
end
