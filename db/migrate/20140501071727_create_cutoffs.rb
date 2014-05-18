class CreateCutoffs < ActiveRecord::Migration
  def change
    create_table :cutoffs do |t|
      t.text :notes
      t.date :date_from
      t.date :date_to
      t.integer :year_from
      t.integer :month_from
      t.decimal :budget, :scale => 2, :precision => 10, :default => 0
      t.decimal :savings, :scale => 2, :precision => 10, :default => 0
      t.decimal :expenses, :scale => 2, :precision => 10, :default => 0
      t.references :user, :index => true

      t.timestamps
    end
  end
end
