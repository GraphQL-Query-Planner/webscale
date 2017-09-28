class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :content_id, null: false
      t.string :content_type, null: false

      t.timestamps
    end
  end
end
