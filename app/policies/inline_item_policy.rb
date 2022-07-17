# frozen_string_literal: true

# inline item policy
class InlineItemPolicy < ApplicationPolicy
  def index?
    admin? || user?
  end
end
