class Praticien::InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.filtered_by_invoiceable(user).ordered_by_date_desc
    end
  end
  def index?
    user.praticien?
  end
  def create?
    user.praticien?
  end
  def update?
    record.praticien.user == user
  end
end
