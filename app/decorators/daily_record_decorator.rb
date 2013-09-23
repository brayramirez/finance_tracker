class DailyRecordDecorator < ApplicationDecorator

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def budget
    h.number_with_precision(object.budget, :precision => 2)
  end


  def expenses
    h.number_with_precision(object.expenses, :precision => 2)
  end

end
