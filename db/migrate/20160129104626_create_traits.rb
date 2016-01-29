class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.string :trait
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
