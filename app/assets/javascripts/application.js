// // = require rails-ujs
// // = require_tree .
//  import mapboxgl from 'mapbox-gl';

// const input = document.querySelector("#form-input");
// const form = document.querySelector("#form");
// const H1coordinates = document.querySelector("h1");

// form.addEventListener('submit', (event) => {
//   event.preventDefault();
//   fetch(`https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=${input.value}&inputtype=textquery&locationbias=circle:2000@45.489253,-73.571144&key=AIzaSyCgYHWe811R-jDIKjTq0isYrQuYgSKpxF0`)
//     .then(response => response.json())
//     .then((data) => {
//       console.log(data);
//       // console.log(data.features[0].center[0]);
//       const geo = data.features[0].center;
//       H1coordinates.innerText = `${geo}`;
//       mapboxgl.accessToken = 'AIzaSyCgYHWe811R-jDIKjTq0isYrQuYgSKpxF0';
//       const map = new mapboxgl.Map({
//         container: 'map',
//         style: 'mapbox://styles/mapbox/streets-v9',
//         center: geo,
//         zoom: 12
//       });
//       new mapboxgl.Marker()
//         .setLngLat(geo)
//         .addTo(map);
//     });
// });
