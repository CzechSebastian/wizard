import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();

const criteria = document.querySelector("#submit-criteria")
const district = document.querySelector("#districts-card")
const categoryChoices = document.querySelectorAll(".category-choice")
const categoryMessage = document.querySelector(".criteria-title")

categoryChoices.forEach((category) => {
  category.addEventListener("click", (event) => {
    $(district).slideDown();

    let count = document.querySelectorAll(".category-choice.active").length;
    const hasClassActive = category.classList.contains("active");

    if (count < 3 || hasClassActive) {
      category.classList.toggle("active")
      count = document.querySelectorAll(".category-choice.active").length;
      setTimeout(() => {
        criteria.click();
        if (count === 0) {
          $(district).slideUp();
          categoryMessage.innerHTML = "Select your 3 main criterias"
        }else if (count === 1) {
          categoryMessage.innerHTML = "You have 2 more criterias left"
        }else if (count === 2) {
          categoryMessage.innerHTML = "You have 1 more criteria left"
        }else if (count === 3) {
          categoryMessage.innerHTML = "We've summed up the best districts!"
        }
      }, 50)
    } else {
      categoryMessage.innerHTML = "Too many picked!"
      categoryMessage.classList.add("shake")
      setTimeout(() => {
        categoryMessage.classList.remove("shake")
      }, 1000)
    }

  })
})

//Button to top
// var btn = $('#scroll-button');

// $(window).scroll(function() {
//   if ($(window).scrollTop() > 300) {
//     btn.addClass('show');
//   } else {
//     btn.removeClass('show');
//   }
// });

// btn.on('click', function(e) {
//   e.preventDefault();
//   $('html, body').animate({scrollTop:0}, '300');
// });
