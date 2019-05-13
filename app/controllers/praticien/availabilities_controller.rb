class Praticien::AvailabilitiesController < ApplicationController
  def index
    @availabilities = policy_scope([:praticien, Availability])
    authorize([:praticien, Availability])
    render layout: "dashboard"
  end

  def update
    @availability = Availability.find(params[:id])
    authorize ([:praticien, @availability])
    @availability.status = params[:status].to_i
    if @availability.save
      redirect_to praticien_availabilities_path
    else
      render "praticien/availabilities", layout: "dashboard"
    end
  end
end
