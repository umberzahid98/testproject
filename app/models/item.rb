class Item < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price,  :numericality => { :only_float => true, :greater_than => 0 }
  validate :image_type


  private
  def image_type
    if (image.attached?)== false
      errors.add(:image, "is missing")
    end

  end




end
