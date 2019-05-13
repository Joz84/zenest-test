class Praticien::EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.filtered_by_calendar_active.filtered_by_praticien(user).ordered_by_start_date.group_by_future_past.each_with_object({}) { |(k, v), a| a[k] = v.group_by{|event| [event.calendar_day, event.company]}}
    end
  end
  def index?
    user.praticien?
  end
  def print?
    user.praticien?
  end
  def print_planning_day?
    user.praticien?
  end
end

