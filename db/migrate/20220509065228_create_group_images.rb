class CreateGroupImages < ActiveRecord::Migration[6.1]
  def change
    create_table :group_images do |t|
      t.integer :group_id

      t.timestamps
    end
  end
end
