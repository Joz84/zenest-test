class Employee::AttendeePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    user.employee?
  end

  def create?
    user.company == record.event.company # uniquement les employés de la compagnie peuvent créer un attendee
  end

  def update?
    user.admin || record.employee.user == user || user.actable.admin_company
  end

  def destroy?
    user.admin
  end
end
