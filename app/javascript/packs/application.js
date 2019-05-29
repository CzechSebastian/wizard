import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();


// const toggleActiveClass = (event) => {
//   event.currentTarget.classList.toggle('active');
// };

// const toggleActiveOnClick = (box) => {
//   box.addEventListener('click', toggleActiveClass);
// };

// const icons = document.querySelectorAll(".clickable");

// icons.forEach((icon) => {
//   toggleActiveOnClick(icon);
// });

// toogle button
$(document).ready(function(){
  $(".category-choice").click(function(){
    $(this).toggleClass("active");
    setTimeout(() => {
      $("#submit-criteria").click();
    }, 100)
  });
});


// const active = document.querySelectorAll(".active");
// active.forEach((selection) => {
//   selection.addEventListener('click', () => {
//     console.log("forEach worked");
//   });
// });
