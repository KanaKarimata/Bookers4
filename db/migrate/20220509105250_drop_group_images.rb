class DropGroupImages < ActiveRecord::Migration[6.1]
  def change
    drop_table :group_images
  end
end
