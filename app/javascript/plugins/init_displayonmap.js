
const fetchDistrict = (url) => {
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      const name = districts_attributes.name;
      const score = districts_attributes.score;
      const district = features.geometry.coordinates;
    });
};


//   const restaurant = document.querySelector(".restaurant");

//   restaurant.addEventListener('click', (event) => {
//   event.preventDefault();
//   const url = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=45.522,-73.607&radius=5000&type=restaurant&key=AIzaSyCgYHWe811R-jDIKjTq0isYrQuYgSKpxF0`;
//   console.log("clicked")
// })
