class RemoveGoupIdFromGroupUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :group_users, :goup_id, :integer
  end
end
