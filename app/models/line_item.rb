# == Schema Information
#
# Table name: line_items
#
#  id              :integer          not null, primary key
#  amount          :decimal(10, 2)   default(0.0)
#  description     :text
#  daily_record_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class LineItem < ActiveRecord::Base

  after_save :update_total_expenses


  belongs_to :daily_record


  validates :amount, :numericality => true



private

  def update_total_expenses
    self.daily_record.update_attributes :expenses => self.daily_record.line_items.sum(:amount)
  end

end
