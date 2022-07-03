# frozen_string_literal: true

# order class
class Order < ApplicationRecord
  scope :user_orders, -> (user_id) { where(user_id: user_id) }
  belongs_to :user
  validates :status, presence: true
  enum status: %i[ordered paid completed cancelled]
  # setting the default status at hte time of creation
  after_initialize :set_default_status, if: :new_record?
  def set_default_status
    self.status ||= :ordered
  end
end
