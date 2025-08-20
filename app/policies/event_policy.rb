class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (owner? || admin?)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (owner? || admin?)
  end

  private

  def owner?
    user == record.user
  end

  def admin?
    user&.admin?
  end
end
