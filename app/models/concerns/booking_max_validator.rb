class BookingMaxValidator < ActiveModel::Validator
  def validate(record)
    attendees = Attendee.confirmed.filtered_by_employee_and_massage_category(record.employee,record.massage_category)
    booking_restriction = BookingRestriction.filtered_by_attendee(record)
    periodicity = booking_restriction.periodicity
    current_periodicity = (periodicity == "month" ? record.event_month : record.event_week)
    attendees_count = attendees.filtered_by_periodicity(periodicity, current_periodicity).count

    if attendees_count >= booking_restriction.rate
      record.errors[:event] << "Vous avez dépassé le maximun d'inscriptions autorisées de : #{booking_restriction.rate} par #{booking_restriction.periodicity}"
    end
  end
end
