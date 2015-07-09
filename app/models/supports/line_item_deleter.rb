class LineItemDeleter

  attr_accessor :line_item, :daily_record


  def initialize line_item
    raise 'Invalid parameter' unless line_item.is_a?(LineItem)

    self.line_item = line_item
    self.daily_record = self.line_item.daily_record
  end


  def delete
    self.line_item.delete

    DailyRecordCalculator.new(self.daily_record).calculate
  end

end
