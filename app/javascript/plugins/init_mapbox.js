import mapboxgl from 'mapbox-gl';


const initIndexMap = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    const coordinatesForm = document.getElementById('coordinates-form')
  const refreshMapButton = document.getElementById('refresh-map')
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;


  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10',
    center: [-73.61, 45.551],
    zoom: 9.5,
  });


  document.getElementById('submit-to-fly').addEventListener('click', function () {
    let districtCenter = document.getElementById("fly-to").value;
    districtCenter = JSON.parse(districtCenter.replace(/&quot;/g,'"'));
    map.flyTo({
      center: districtCenter,
      zoom: 12.3
    });
  });


  refreshMapButton.addEventListener('click', function(){
    const polygons = JSON.parse(inputBox.value.replace(/&quot;/g,'"'));


      // Checking if there is a layer that starts with "montreal_"
      const districtLayerIsPresent = map.getStyle().layers.some((layer) => {
        return layer.id.match(/^montreal_/) !== null
      });

      if (districtLayerIsPresent === true){
        // removing all montreal layers

        map.getStyle().layers.forEach((layer) => {
          if (layer.id.match(/^montreal_/) !== null) {
            map.removeLayer(layer.id);
            map.removeSource(layer.id);
          }
        })
      }
      if (true) {
        // adding polygons
        polygons.forEach((polygon, index) => {
          map.addLayer({
            'id': `montreal_${index}`, // dynamic name for each polygon (starts with "montreal_")
            'type': 'fill',
            'source': {
              'type': 'geojson',
              'data': {
                'type': 'Feature',
                'properties': {
                  "name": polygon["name"]
                },
                'geometry': {
                  'type': 'Polygon',
                  'coordinates': [polygon["coordinates"]]
                }
              }
            },
            'layout': {},
            'paint': {
              'fill-color': '#5CBCF7',
              'fill-opacity': 0.7,
            }
          })
          map.on('click', `montreal_${index}`, function (e) {
            console.log(e)
            new mapboxgl.Popup()
            .setLngLat(e.lngLat)
            .setHTML('<a href="' + polygon['url'] + '">' + e.features[0].properties.name + '</a>')
            .addTo(map);
          })
        });
      }
    })

}
};

// =========================show map=================================================================
const filters = []
let previousFilters = []
let newFilters = []

const mapShow = document.getElementById('show-map');
let markers = []
let markerObjects = []
let map = null;

const categoryClasses = {
  restaurants: '<div class="marker-item"><i class="fas fa-utensils"></i></div>',
  schools: '<div class="marker-item"><i class="fas fa-graduation-cap""></i></div>',
  bars: '<div class="marker-item"><i class="fas fa-glass-martini-alt"></i></div>',
  subways: '<div class="marker-item"><i class="fas fa-subway"></i></div>',
  parks: '<div class="marker-item"><i class="fas fa-leaf"></i></div>'

}

const initShowMap = () => {
  const mapElement = document.getElementById('show-map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    const markerObjects = []

    // const restaurantsBtn = document.querySelector("#restaurant-btn")
    // restaurantsBtn.addEventListener("click", (event) => {
    //   if (restaurantsBtn.classList.contains("clicked")) {
    //     removeMarkers(markerObjects)
    //   } else {
    //     addMarkers("restaurants", markerObjects, map, mapElement)
    //   };
    //   restaurantsBtn.classList.toggle("clicked")
    // });

    // const schoolsBtn = document.querySelector("#school-btn")
    // schoolsBtn.addEventListener("click", (event) => {
    //   if (schoolsBtn.classList.contains("clicked")) {
    //     removeMarkers(markerObjects)
    //   } else {
    //   addMarkers("schools", markerObjects, map, mapElement);
    //   };
    //   restaurantsBtn.classList.toggle("clicked")
    // });

    // document.querySelector("#park-btn").addEventListener("click", (event) => {
    //   setMarkers("parks", markerObjects, map, mapElement);
    // });

    // document.querySelector("#subway-btn").addEventListener("click", (event) => {
    //   setMarkers("subways", markerObjects, map, mapElement);
    // });

    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const center = JSON.parse(mapElement.dataset.center)
    const coordinates = JSON.parse(mapElement.dataset.coordinates)

    map = new mapboxgl.Map({
      container: 'show-map',
      style: 'mapbox://styles/mapbox/streets-v10',
      center: center,
      zoom: 13,
      attributionControl: false
    });

    map.on('load', function() {
      map.addLayer({
        'id': 'maine',
        'type': 'line',
        'source': {
          'type': 'geojson',
          'data': {
            'type': 'Feature',
            'geometry': {
              'type': 'Polygon',
              'coordinates': [coordinates]
            }
          }
        },
        'layout': {},
        'paint': {
          'line-color': '#FF6057',
          'line-width': 4
        }
      });
    });

    // map.addControl(new MapboxGeocoder({
    //   accessToken: mapboxgl.accessToken,
    //   marker: {
    //   },
    //   mapboxgl: mapboxgl
    // }));


  }
};

const handleFilters = (category) => {
  previousFilters = JSON.parse(JSON.stringify(filters));

  if (filters.includes(category)) {
    var index = filters.indexOf(category)
    filters.splice(index, 1);
  } else {
    filters.push(category)
  };
};

const triggerMapRefresh = () => {
  console.log("Filters")
  console.log(filters)
  console.log("previousFilters")
  console.log(previousFilters)
  filters.forEach((category) => {
    if (!previousFilters.includes(category)) {
      markers.push(JSON.parse(mapShow.dataset[category]));
    }
  })
  console.log(markers);
  markers = markers.flat();

  markers.forEach((marker) => {

    setTimeout(() => {
      var e = document.createElement('div');
      e.innerHTML = categoryClasses[marker.category]
      e.className = 'marker-' + marker.category;
      e.wizcategory = marker.category;
      const newMarker = new mapboxgl.Marker(e)
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
      markerObjects.push(newMarker)
    }, Math.floor(Math.random() * Math.floor(1000)))

  });
  markers = [];
}

document.querySelectorAll(".btn-show-category").forEach((element) => {
  element.addEventListener("click", (event) => {
    // console.log(element.getAttribute("data-value"))

    handleFilters(element.getAttribute("data-value"));
    deleteAllMarkers();
    console.log(filters)
    triggerMapRefresh()
  })
});

const deleteAllMarkers = () => {
  markerObjects.forEach((marker) => {
   if (!filters.includes(marker._element.wizcategory)) {
    marker.remove()
  }
});
}



const initMapbox = () => {
  initIndexMap()
  initShowMap()
};

export { initMapbox };
