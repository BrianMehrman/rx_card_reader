class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :number
      t.date :exp_date
      t.integer :lot_id

      t.timestamps
    end
  end
end
