class LineItemForm < Reform::Form

  properties(
    :description,
    :amount
  )


  validates(
    :amount,
    :description,
    :presence => true
  )


  def save
    super

    DailyRecordCalculator.new(self.model.daily_record).calculate
  end

end
