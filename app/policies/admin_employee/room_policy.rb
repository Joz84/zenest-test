class AdminEmployee::RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #Right list to be given
      scope.filtered_by_company(user).ordered_by_id_desc
    end
  end
  def index?
    user.admin_employee? && user.company.rooms.ordered_by_id_desc == record
  end
  def create?
    user.admin_employee? && record.company == user.company
  end
  def update?
    user.admin_employee? && record.company == user.company
  end
  def destroy?
    user.admin_employee? && record.company == user.company
  end
  def show?
    user.admin_employee?
  end
end
