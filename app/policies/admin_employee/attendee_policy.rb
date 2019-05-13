class AdminEmployee::AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.filtered_by_company(user)
    end
  end
  def index?
    # a ameliorer
    user.admin_employee?
  end
  def create?
    user.admin_employee?
  end
  def update?
    !record.event.calendar.payable && user.admin_employee?
  end
end
