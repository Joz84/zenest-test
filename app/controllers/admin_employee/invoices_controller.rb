class AdminEmployee::InvoicesController < ApplicationController
  def index
    @invoices = policy_scope([:admin_employee, Invoice])
    authorize([:admin_employee, @invoices])
    render layout: "dashboard"
  end
end
