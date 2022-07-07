class InlineItemPolicy < ApplicationPolicy
  def create?
    user?
  end
  def update?
    user?
  end
  def destroy?
    user?
  end
  def index?
    admin? || user?
  end
end
