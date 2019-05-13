import { initSubmission } from './payment.js'

const collapsePayment = document.querySelector(".mhv-collapse-payment");
const collapseHeader = document.querySelector(".mhv-collapse-header");

const fetchMassageCategoriesForAttendeesNew = (calendarDayId) => {
  const url = `../../employee/calendar_day/${calendarDayId}/available_massage_categories`;
  fetch(url, { credentials: 'include' })
  .then(response => response.json())
  .then((massageCategories) => {
    const calendarDayDate = document.querySelector("#attendee-modal-date");
    calendarDayDate.innerHTML = massageCategories[0].event_dates[0].daily_date;
    const collapse = document.querySelector("#attendee-modal-massage-categories");
    collapse.innerHTML = generateModalContentHTML(massageCategories);
    activeModalCollapse();
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
    <div class="d-flex align-items-baseline justify-content-left flex-wrap">
    ${eventDate.events.map( eventHTML ).join('')}
    </div>
  </div>`
}

const eventHTML = (event) => {
  if (event.employee_registration) {
    return bookedEventHTML(event);
  } else if ( event.available_attendees_count === 0 || event.past || event.praticien_is_nil ) {
    return fullEventHTML(event);
  }
  else {
    return selectableEventHTML(event);
  }
}

const fullEventHTML = (event) => {
  return `<div class="opacity-05">${eventInfosHTML(event, "red-circle")}</div>`
}

const selectableEventHTML = (event) => {
  return `<label for="attendee_event_id_${event.event_id}" class="custom-radio">
    <div class="d-none mhv-collapse-item-price">${event.price}</div>
    <div class="d-none mhv-collapse-item-payable">${event.payable}</div>
    ${eventInfosHTML(event, "")}
  </label>
  <input type="radio" value="${event.event_id}" name="attendee[event_id]" class="d-none" id="attendee_event_id_${event.event_id}" />
  `
}

const bookedEventHTML = (event) => {
  return `<div class="opacity-05">${eventInfosHTML(event, "blue-circle")}</div>`
}

const eventInfosHTML = (event, imgClass) => {
  return `<img src="${event.praticien_url}" alt="${event.praticien_username}" class="small-avatar mx-2 ${imgClass}">
    <div class="font-13px">${event.praticien_username}</div>
    <div class="font-13px text-secondary">${event.available_attendees_count}/${event.max_attendees}</div>`
}

const generatePaymentHTML = (payable, price) => {
  if (payable) {
    collapsePayment.innerHTML = `<hr>
      <h4 class="mt-4">Paiement de ${price}€</h4>
      <div id="card-element" class="mx-5 my-2"></div>
      <div id="card-errors" role="alert"></div>
      <button class="blue-button mx-auto mt-3">Payer</button>`
    initSubmission("pk_test_5BK5iGzkagsMPodeygiULgjJ");
  } else {
    collapsePayment.innerHTML = `<hr>
      <h4 class="mt-4">Cette prestation est offerte par votre société</h4>
      <button class="blue-button mx-auto mt-3">Valider</button>`
  }
}

const activeModalCollapse = () => {
  initGroupsVisibility();
  const collapseImgs = document.querySelectorAll(".custom-radio .small-avatar");
  collapseHeader.addEventListener("click", initGroupsVisibility);
  collapseImgs.forEach(selectImg);
}

const initGroupsVisibility = () => {
  const collapseH0s = document.querySelectorAll("#mhv-collapse .mhv-h0");
  collapseH0s.forEach( h0 => h0.classList.remove("mhv-h0") );
  collapsePayment.innerHTML = "";
  collapsePayment.classList.add("mhv-h0");
}

const selectImg = (img) => {
  const collapseGroups = document.querySelectorAll(".mhv-collapse-group");
  const item = img.parentElement.parentElement.parentElement
  const price = item.querySelector(".mhv-collapse-item-price").innerText;
  const payable = item.querySelector(".mhv-collapse-item-payable").innerText  === "true";
  const group = item.parentElement;
  img.addEventListener("click", (e) => {
    const inputId = img.parentElement.getAttribute("for");
    const input = document.getElementById(inputId);
    input.checked = true;
    generatePaymentHTML(payable, price);
    collapsePayment.classList.toggle("mhv-h0");
    collapseGroups.forEach((otherGroup) => {
      toggleCollapses(group, otherGroup, item);
    });
  });
}

const toggleCollapses = (group, otherGroup, item) => {
  if (group !== otherGroup) {
   otherGroup.classList.toggle("mhv-h0");
  } else {
    const collapseGroupItems = group.querySelectorAll(".mhv-collapse-item");
    collapseGroupItems.forEach((otherItem) => {
      if (item !== otherItem) { otherItem.classList.toggle("mhv-h0"); }
    });
  }
}

export { fetchMassageCategoriesForAttendeesNew };
