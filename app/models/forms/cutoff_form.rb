require 'reform/form/coercion'


class CutoffForm < Reform::Form

  include Coercion


  properties(
    :notes,
    :budget,
    :savings
  )

  property :date_from, :type => Date
  property :date_to, :type => Date


  validates :date_from, :presence => true, :uniqueness => {:scope => :user_id}
  validates :date_to, :presence => true, :uniqueness => {:scope => :user_id}
  validate :date_range





  private

  def date_range
    return if self.date_from.blank? || self.date_to.blank?
    return if self.date_from < self.date_to

    errors.add :base, 'Invalid date range'
  end

end
