# == Schema Information
#
# Table name: daily_records
#
#  id               :integer          not null, primary key
#  transaction_date :date
#  budget           :decimal(10, 2)   default(0.0)
#  expenses         :decimal(10, 2)   default(0.0)
#  notes            :text
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class DailyRecord < ActiveRecord::Base

  has_many :line_items


  default_scope { order("transaction_date DESC") }


  validates_uniqueness_of :transaction_date, :scope => :user_id
  validates :budget, :numericality => true


  class << self
    def find_by_year_and_month year, month
      where("YEAR(transaction_date) = #{year} AND MONTH(transaction_date) = #{month}")
    end


    def archive
      archive = {}

      self.year_archives.each do |year|
        archive[year] = []

        archive[year] = month_archives(year).map { |month| month }
      end

      archive
    end


    def year_archives
      pluck("DISTINCT YEAR(transaction_date) as year")
    end


    def month_archives year
      where("YEAR(transaction_date) = #{year}").
        pluck("DISTINCT MONTH(transaction_date) as month")
    end

  end

end
