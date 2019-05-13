class Praticien::AvailabilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.filtered_by_praticien(user).group_by(&:status)
    end
  end
  def index?
    user.praticien?
  end
  def update?
    user.praticien?
  end
end

