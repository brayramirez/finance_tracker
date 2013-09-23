class CreateDailyRecords < ActiveRecord::Migration
  def change
    create_table :daily_records do |t|
      t.date :transaction_date
      t.decimal :budget, :scale => 2, :precision => 10, :default => 0
      t.decimal :expenses, :scale => 2, :precision => 10, :default => 0
      t.text :notes
      t.references :user, :index => true

      t.timestamps
    end
  end
end
