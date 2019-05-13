import { initSubmission } from './payment.js'

const collapsePayment = document.querySelector(".mhv-collapse-payment");
const collapseHeader = document.querySelector(".mhv-collapse-header");

const fetchMassageCategoriesForEventsIndex = (calendarDayId) => {
  const url = `../../admin_employee/calendar_day/${calendarDayId}/available_massage_categories`;
  fetch(url, { credentials: 'include' })
  .then(response => response.json())
  .then((massageCategories) => {
    const calendarDayDate = document.querySelector("#event-modal-date");
    calendarDayDate.innerHTML = massageCategories[0].event_dates[0].daily_date;
    const collapse = document.querySelector("#event-modal-massage-categories");
    collapse.innerHTML = generateModalContentHTML(massageCategories);
  });
}

const generateModalContentHTML = (massageCategories) => {
  return `${massageCategories.map( massageCategoryHTML ).join('')}`
};

const massageCategoryHTML = (massageCategory) => {
  return `<div class="mhv-collapse-group"><hr>
  <div class="d-flex align-items-baseline justify-content-between flex-wrap">
    <h5>${ massageCategory.name }</h5>
    <div class="font-13px text-primary">Nb de séances disponibles : <strong>${massageCategory.available_attendees_count}/${massageCategory.max_attendees}</strong></div>
  </div>
    ${massageCategory.event_dates.map( eventDateHTML ).join('')}
</div>`
}

const eventDateHTML = (eventDate) => {
  return `<div class="mhv-collapse-item">
    <h6 class="text-left">${eventDate.start_date} - ${eventDate.end_date}</h6>
    <table-responsive>
      <table class="table quicksandlight">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Praticien</th>
            <th scope="col">Grp./Ind.</th>
            <th scope="col">Nb de participants</th>
            <th scope="col">Salle</th>
            <th scope="col"></th>
          </tr>
        </thead>
        <tbody>
          ${eventDate.events.map( eventHTML ).join('')}
        </tbody>
      </table>
    </table-responsive>
  </div>`
}

const eventHTML = (event) => {
  let  editEventLink = `<a href="${event.show_url}"><i class="fas fa-edit"></i></a>`;
  if (event.past ) { editEventLink = "" }
  return `<tr>
    <td>${ event.event_id }</td>
    <td>${ event.praticien_full_name }</td>
    <td>${ (event.group ? "Groupe" : "Individuel") }</td>
    <td>${ event.confirmed_attendees_count }</td>
    <td>${ event.room }</td>
    <td>${ editEventLink }</td>
  </tr>`

}

export { fetchMassageCategoriesForEventsIndex };
