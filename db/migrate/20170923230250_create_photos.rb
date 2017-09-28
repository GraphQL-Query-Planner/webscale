class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :post_id, null: false
      t.string :photo_url, null: false

      t.timestamps
    end
  end
end
