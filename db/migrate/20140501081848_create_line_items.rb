class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.text :description
      t.decimal :amount, :scale => 2, :precision => 10, :default => 0
      t.references :daily_record

      t.timestamps
    end
  end
end
