class DailyRecordCalculator

  attr_accessor :daily_record


  def initialize daily_record
    raise 'Invalid parameter' unless daily_record.is_a?(DailyRecord)

    self.daily_record = daily_record
  end


  def calculate
    self.daily_record.expenses = self.daily_record.line_items.sum :amount
    self.daily_record.save

    CutoffCalculator.new(daily_record.cutoff).calculate
  end

end
