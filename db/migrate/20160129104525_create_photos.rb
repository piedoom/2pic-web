class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :photo
      t.integer :target_user_id

      t.timestamps null: false
    end
  end
end
