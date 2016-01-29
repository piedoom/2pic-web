class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :key
      t.string :username
      t.string :photo
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
