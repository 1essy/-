class CreateRestComments < ActiveRecord::Migration[6.1]
  def change
    create_table :rest_comments do |t|
      t.text :comment
      t.integer :rest_id
      t.integer :customer_id
      t.integer :star

      t.timestamps
    end
  end
end
