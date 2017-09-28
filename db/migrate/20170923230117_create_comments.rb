class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id, null: false
      t.integer :content_id, null: false
      t.string :content_type, null: false

      t.timestamps
    end
  end
end
