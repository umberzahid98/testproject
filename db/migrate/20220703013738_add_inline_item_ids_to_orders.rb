class AddInlineItemIdsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :inline_item_ids, :integer, array: true, default: []
    #Ex:- :default =>''
  end
end

