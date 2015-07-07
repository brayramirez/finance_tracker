class RemoveYearFromAndMonthFromColumnsFromCutoff < ActiveRecord::Migration

  def up
    remove_column :cutoffs, :year_from
    remove_column :cutoffs, :month_from
  end


  def down
    add_column :cutoffs, :year_from, :integer
    add_column :cutoffs, :month_from, :integer
  end

end
