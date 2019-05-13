class Employee::EventsController < ApplicationController
  def index
    @events = policy_scope([:employee, Event])
    authorize([:employee, Event])
    render layout: "dashboard"
  end
end
