# == Schema Information
#
# Table name: cutoffs
#
#  id         :integer          not null, primary key
#  notes      :text
#  date_from  :date
#  date_to    :date
#  year_from  :integer
#  month_from :integer
#  budget     :decimal(10, 2)   default(0.0)
#  savings    :decimal(10, 2)   default(0.0)
#  expenses   :decimal(10, 2)   default(0.0)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Cutoff < ActiveRecord::Base

	belongs_to :user

	has_many :daily_records, :dependent => :destroy


	validates_uniqueness_of :date_from, :scope => :user_id
	validates_uniqueness_of :date_to, :scope => :user_id

	validates_presence_of :date_from, :date_to
	validate :date_to_before_date_from


	after_validation :extract_year_month


	scope :latest, -> { order("date_from DESC") }


	class << self
		def include date
			where("date_from <= ?::date AND date_to >= ?::date",
				date, date).first
		end


		# def find_by_year_and_month year, month
		# 	where(:year_from => year, :month_from => month)
		# end


		def year_list
			pluck("DISTINCT year_from AS year")
		end


		def list_by_year year
			where("year_from = #{year}")
		end
	end


	def to_s
		s = "#{Date::MONTHNAMES[self.date_from.month]} #{self.date_from.day} to "
		s += "#{Date::MONTHNAMES[self.date_to.month]} #{self.date_to.day}"

		s
	end


	def header
		s = "#{Date::MONTHNAMES[self.date_from.month]} #{self.date_from.day}, #{self.date_from.year} to "
		s += "#{Date::MONTHNAMES[self.date_to.month]} #{self.date_to.day}, #{self.date_to.year}"

		s
	end


	def within_dates date
		date >= self.date_from && date <= self.date_to
	end



private

	def date_to_before_date_from
		if (self.date_from && self.date_to) && (self.date_from >= self.date_to)
			errors.add(:date_to, 'Date to should be after Date From')
		end
	end


	def extract_year_month
		self.year_from = self.date_from.year
		self.month_from = self.date_from.month
	end

end
