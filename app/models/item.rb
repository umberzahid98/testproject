# frozen_string_literal: true

# class of items that the admin will create
class Item < ApplicationRecord
  has_many :category_items
  has_many :categories, through: :category_items
  # validates_associated :categories

  has_one_attached :image
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, numericality: { only_float: true, greater_than: 0 }
  validate :save_object?
  # validate :no_category
  # validate :image_type

  private

  def save_object?
    if Category.all.count.zero?
      errors.add(:category, 'should be created first') if Category.all.count.zero?
    elsif category_ids.count.zero?
      errors.add(:category, 'is not selected')
    end
  end

  # def image_type
  #   errors.add(:image, 'is missing') if (image.attached?) == false
  # end
end
