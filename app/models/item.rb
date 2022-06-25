class Item < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price,  :numericality => { :only_float => true, :greater_than => 0 }


end
