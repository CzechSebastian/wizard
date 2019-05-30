import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';


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
      attributionControl: false
    });

    map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      marker: {
      },
      mapboxgl: mapboxgl
    }));


    refreshMapButton.addEventListener('click', function(){
      const polygons = JSON.parse(inputBox.value);

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
      } else {
        // adding polygons
        polygons.forEach((polygon, index) => {
          map.addLayer({
            'id': `montreal_${index}`, // dynamic name for each polygon (starts with "montreal_")
            'type': 'fill',
            'source': {
              'type': 'geojson',
              'data': {
                'type': 'Feature',
                'geometry': {
                  'type': 'Polygon',
                  'coordinates': [polygon]
                }
              }
            },
            'layout': {},
            'paint': {
              'fill-color': '#FF0000',
              'fill-opacity': 0.8,
            }
          })
        })
      }
    })

  }
};

// ==========================================================================================

document.querySelectorAll(".btn").forEach((btn) => {
  btn.addEventListener("click", (event) => {
    console.log(event);
  });
});


const initShowMap = () => {
  const mapElement = document.getElementById('show-map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const center = JSON.parse(mapElement.dataset.center)
    const coordinates = JSON.parse(mapElement.dataset.coordinates)

    const map = new mapboxgl.Map({
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

    map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      marker: {
      },
      mapboxgl: mapboxgl
    }));

    const markers = JSON.parse(mapElement.dataset.restaurants);
    if (markers !== null ) {
      markers.forEach((marker) => {
        new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
      });
    }
  }
};

const initMapbox = () => {
  initIndexMap()
  initShowMap()
};

export { initMapbox };
