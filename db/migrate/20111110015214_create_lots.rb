class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.integer :number
      t.integer :quantity

      t.timestamps
    end
  end
end
