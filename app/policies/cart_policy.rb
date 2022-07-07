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
