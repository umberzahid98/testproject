class CategoryPolicy < ApplicationPolicy
  def create?
    admin?
  end
  def index?
    admin?
  end

end
