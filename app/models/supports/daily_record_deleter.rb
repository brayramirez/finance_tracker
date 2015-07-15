class DailyRecordDeleter

  attr_accessor :daily_record, :cutoff


  def initialize daily_record
    raise 'Invalid parameter' unless daily_record.is_a?(DailyRecord)

    self.daily_record = daily_record
    self.cutoff = self.daily_record.cutoff
  end


  def delete
    self.daily_record.delete

    CutoffCalculator.new(self.cutoff).calculate
  end

end
