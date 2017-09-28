class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :user_id, null: false
      t.integer :receiver_id, null: false

      t.timestamps
    end
  end
end
