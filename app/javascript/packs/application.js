// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { initStarRating } from '../plugins/init_star_rating';


/* import { initCaroussel } from '../components/caroussel';

document.addEventListener('turbolinks:load', () => {
  initCaroussel();
}); */


function order_by_occurrence(arr) {
  var counts = {};
  arr.forEach(function (value) {
    if (!counts[value]) {
      counts[value] = 0;
    }
    counts[value]++;
  });
  return Object.keys(counts).sort(function (curKey, nextKey) {
    return counts[curKey] < counts[nextKey];
  });
}

import { initScanner } from '../plugins/init_scanner';
import { initHeart } from '../components/heartbtn';
import { displayDiv } from '../components/displaydiv';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2(); 
  initScanner();
  initHeart();
  initStarRating();
  displayDiv();

});

let togg1 = document.getElementById("togg1");

let d1 = document.getElementById("d1");
if (togg1) {
  togg1.addEventListener("click", () => {
    if (getComputedStyle(d1).display != "none") {
      d1.style.display = "none";
    } else {
      d1.style.display = "block";
    }
  })
}






