class CutoffCalculator

  attr_accessor :cutoff


  def initialize cutoff
    raise 'Invalid parameter' unless cutoff.is_a?(Cutoff)

    self.cutoff = cutoff
  end


  def calculate
    self.cutoff.expenses = self.cutoff.daily_records.sum :expenses
    self.cutoff.save
  end

end
