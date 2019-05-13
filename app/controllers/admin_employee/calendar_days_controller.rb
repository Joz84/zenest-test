class AdminEmployee::CalendarDaysController < ApplicationController

  def available_massage_categories
    @calendar_day = CalendarDay.find(params[:calendar_day_id])
    authorize([:employee, @calendar_day])
    @employee = current_user.actable
    @massage_categories = @employee.active_events
                                   .filtered_by_calendar_day(@calendar_day)
                                   .formated_for_modal_callendar(@employee)
  end
end
