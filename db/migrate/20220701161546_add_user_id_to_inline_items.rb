class AddUserIdToInlineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :inline_items, :user_id, :integer
  end
end
