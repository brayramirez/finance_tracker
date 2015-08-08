class DailyRecordForm < Reform::Form

  properties(
    :notes,
    :transaction_date,
    :budget
  )


  validates :transaction_date,
    :presence => true,
    :uniqueness => {:scope => :cutoff_id}
  validate :within_cutoff_date





  private

  def within_cutoff_date
    return if self.model.transaction_date.blank?
    return if self.model.cutoff.include?(self.transaction_date)

    errors.add(:transaction_date, 'must be within Cutoff Dates')
  end

end
