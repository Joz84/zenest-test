import flatpickr from "flatpickr";
import "flatpickr/dist/themes/material_blue.css";
import { French } from "flatpickr/dist/l10n/fr.js"; // A path to the theme CSS
flatpickr(".flatpickr", {
  "locale": French
});
