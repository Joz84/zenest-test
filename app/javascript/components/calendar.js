import { fetchMassageCategoriesForAttendeesNew } from "./employee_attendees_new_modal.js"
import { fetchMassageCategoriesForEventsIndex } from "./admin_employee_events_index_modal.js"

const displayCalendar = (calendar) => {
  const events = JSON.parse(calendar[0].dataset.events);
  calendar.fullCalendar({
    // defaultView: 'agendaDay',
    // header: { center: 'month,agendaWeek' },
    lang: 'fr',
    events: events,
    eventRender: function(event, element) {
      // element.popover({ content: event.description });
      element[0].addEventListener("click", (e) => {
        if ($('#attendeeModal').length) {
          fetchMassageCategoriesForAttendeesNew(event.calendar_day_id);
          $('#attendeeModal').modal('toggle');
        } else if ($('#eventModal').length) {
          fetchMassageCategoriesForEventsIndex(event.calendar_day_id)
          $('#eventModal').modal('toggle');
        }
      });
    }
  });
}

export { displayCalendar }

