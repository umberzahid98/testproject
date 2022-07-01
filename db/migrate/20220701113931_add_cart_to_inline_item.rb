class AddCartToInlineItem < ActiveRecord::Migration[5.2]
  def change
    add_column :inline_items, :cart, :integer
  end
end
