class Employee::EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
     scope.filtered_by_calendar_active.filtered_by_employee(user).ordered_by_start_date.group_by_future_past
    end
  end
  def index?
    user.employee?
  end
end
