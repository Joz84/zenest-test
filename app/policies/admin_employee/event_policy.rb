class AdminEmployee::EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.filtered_by_calendar_active.filtered_by_company(user)
    end
  end
  def index?
    # a ameliorer
    user.admin_employee?
  end
  def print?
    # a ameliorer
    user.admin_employee?
  end
  def show?
    user.admin_employee? && record.company == user.company
  end
  def print_planning_day?
    user.admin_employee?
  end

end
