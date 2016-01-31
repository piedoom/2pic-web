class UsePaperclipInsteadOfCarrierwave < ActiveRecord::Migration
  def change
    remove_column :photos, :photo
    remove_column :users, :photo
    add_attachment :photos, :photo
    add_attachment :users, :photo
  end
end
