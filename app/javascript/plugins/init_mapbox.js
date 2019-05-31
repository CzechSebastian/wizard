import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';


const initMapbox = () => {
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
    const polygons = JSON.parse(inputBox.value.replace(/&quot;/g,'"'));

      console.log(polygons)

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
              'fill-color': '#FF0000',
              'fill-opacity': 0.8,
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



export { initMapbox };
