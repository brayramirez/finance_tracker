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


	after_save :refresh_cutoff


	def to_s
		self.transaction_date.strftime('%B %-d, %Y')
	end


	# TODO: Move to Helper/Form
	def refresh
		self.update_attributes :expenses => self.line_items.sum(:amount)
	end





	private

	def within_cutoff_dates
		return if self.transaction_date.blank?

		if !self.cutoff.include?(self.transaction_date)
			errors.add(:transaction_date, 'must be within Cutoff Dates')
		end
	end


	# TODO: Move to Helper/Form
	def refresh_cutoff
		self.cutoff.update_attributes :expenses => total_expenses
	end


	def total_expenses
		self.cutoff.daily_records.sum :expenses
	end

end
