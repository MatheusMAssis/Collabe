class RegistrationPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end
end
