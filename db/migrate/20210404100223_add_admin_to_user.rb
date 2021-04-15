class AddAdminToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :coord_users, :admin, :boolean, default: false
  end
end
