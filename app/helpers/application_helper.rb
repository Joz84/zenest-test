module ApplicationHelper

  def group_or_individual_event(event)
    event.group? ? "Groupe" : "Individuel"
  end

  def attendee_status_icon(attendee)
    attendee.status == "confirmed" ? "fas fa-check" : "fas fa-times"
  end

  def attendee_status_color(attendee)
    attendee.status == "confirmed" ? "success" : "danger"
  end

  def attendee_status_name(attendee)
    attendee.status == "confirmed" ? "Confirmée" : "Annulée"
  end

  def massage_category_name_for(events_list)
    events_list.map{ |event| event.massage_category.name }.join(', ')
  end

  def default_photo(photo, class_photo, alt = "")
    (cl_image_tag  photo, class: class_photo, alt: alt, width: 600, crop: "scale", quality: "auto:best", :fetch_format=>:auto) if photo
  end

  def employee_dashboard_path(employee)
    if employee.admin_company
      render 'admin_employee/toolbar_admin_employee'
    else
      render 'employee/toolbar_employee'
    end
  end

end
