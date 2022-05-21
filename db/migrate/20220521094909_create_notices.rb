class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.integer :send_id
      t.integer :receive_id
      t.integer :rest_id
      t.integer :rest_comment_id
      t.string :action
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
    # add_index :notices, :receive_id
    # add_index :notices, :send_id
    # add_index :notices, :rest_id
    # add_index :notices, :rest_comment_id
  end
end

