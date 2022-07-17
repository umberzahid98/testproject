# frozen_string_literal: true

# cart policy
class CartPolicy < ApplicationPolicy
  def create?
    user?
  end

  def destroy?
    user?
  end

  def index?
    user?
  end
end
