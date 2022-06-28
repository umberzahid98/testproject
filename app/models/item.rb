# frozen_string_literal: true

class Item < ApplicationRecord
  has_and_belongs_to_many :categories

  has_one_attached :image
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, numericality: { only_float: true, greater_than: 0 }
  validate :image_type

  private

  def image_type
    errors.add(:image, 'is missing') if (image.attached?) == false
  end
end
