# frozen_string_literal: true

# class of items that the admin will create
class Item < ApplicationRecord
  has_many :category_items
  has_many :categories, through: :category_items, dependent: :destroy
  # after_save :hide_modal
  # validates_associated :categories

  has_one_attached :image
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, numericality: { only_float: true, greater_than: 0 }
  validate :save_object?

  enum status: %i[permit not_permit]
  # setting the default status at hte time of creation
  after_initialize :set_default_status, if: :new_record?
  def set_default_status
    self.status ||= :permit
  end

  # validate :no_category
  # validate :image_type

  private

  # def hide_modal

  # end

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
