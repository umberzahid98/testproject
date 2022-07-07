class OrderPolicy < ApplicationPolicy
  def index?
    admin? || user?
  end
  def update?
    admin?
  end
  def update?
    admin?
  end
  def create?
    user?
  end

end
