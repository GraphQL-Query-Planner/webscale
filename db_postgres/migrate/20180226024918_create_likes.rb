class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      # t.references :user, null: false
      # t.references :content, null: false, polymorphic: true

      t.timestamps

      # t.index [:user_id, :content_id, :content_type]
    end
  end
end
