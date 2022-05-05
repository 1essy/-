class CreateRests < ActiveRecord::Migration[6.1]
  def change
    create_table :rests do |t|
      t.text :describe
      t.integer :move_method
      t.integer :smoking_area
      t.integer :toilet
      t.integer :customer_id

      t.timestamps
    end
  end
end
