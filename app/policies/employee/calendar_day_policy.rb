class Employee::CalendarDayPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def available_massage_categories?
    true
    # user.actable.available_calendar_days.include?(record)
  end
end
