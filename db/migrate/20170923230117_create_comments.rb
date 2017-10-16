class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :author, null: false
      t.references :content, null: false, polymorphic: true
      t.integer :content_id, null: false
      t.string :content_type, null: false

      t.timestamps
    end
  end
end
