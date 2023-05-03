class PropertyPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    update?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end
