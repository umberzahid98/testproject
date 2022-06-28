# has_and_belongs_to_many
class JoinCategoriesItems < ActiveRecord::Migration[5.2]
  # has_and_belongs_to_many between items  and catgories
  def change
    create_table :categories_items, id: false do |t|
      t.belongs_to :category
      t.belongs_to :item
    end
  end
end
