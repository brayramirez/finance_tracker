# == Schema Information
#
# Table name: cutoffs
#
#  id         :integer          not null, primary key
#  notes      :text
#  date_from  :date
#  date_to    :date
#  budget     :decimal(10, 2)   default(0.0)
#  savings    :decimal(10, 2)   default(0.0)
#  expenses   :decimal(10, 2)   default(0.0)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Cutoff < ActiveRecord::Base

  module DATE_FORMAT
    SIDEBAR = '%b %-d'
    HEADER = '%B %-d, %Y'
  end


  belongs_to :user

  has_many :daily_records, :dependent => :destroy


  scope :latest, -> { order('date_from DESC') }


  class << self
    def current
      where("Date(?) BETWEEN date_from AND date_to", Date.today).first ||
        self.last
    end


    def year_list
      pluck(:date_from).map(&:year).uniq
    end


    def list_by_year year
      where("EXTRACT(YEAR FROM date_from) = ?", year)
    end
  end


  def to_s
    [self.date_from.strftime(DATE_FORMAT::SIDEBAR),
      self.date_to.strftime(DATE_FORMAT::SIDEBAR)].join ' to '
  end


  def header
    [self.date_from.strftime(DATE_FORMAT::HEADER),
      self.date_to.strftime(DATE_FORMAT::HEADER)].join ' to '
  end


  def include? date
    range = self.date_from..self.date_to
    range === date.to_date
  end


  # TODO: Move to Helper/Form
  def refresh
    self.update_attributes :expenses => self.daily_records.sum(:expenses)
  end

end
