class AdminEmployee::InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #Right list to be given
      scope.filtered_by_invoiceable_company(user).ordered_by_date_desc

    end
  end
  def index?
    # a ameliorer
    user.admin_employee? && user.company.invoices.ordered_by_date_desc == record
  end
end
