<template>
  <div class="main">
    <Sidebar :map="map" @set-marker="setMarker" :center="center" @found-places="showMarkers"/>
    <div class="map-wrapper">
      <div id="map"></div>
      <button class="btn btn-light m-1" id="fly">Let's go Izumo!</button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import "@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css";
import initMap from './map.js';
import Sidebar from './TheSidebar.vue'

export default {
  components: {
    Sidebar,
  },
  data() {
    return {
      loading: false,
      location: "",
      access_token: this.$mapboxApiKey,
      center: [132.7445942, 35.3665752],
      map: {},
    };
  },

  mounted() {
    this.createMap()
  },

  methods: {
    async createMap() {
      try {
        this.map = initMap(this.access_token);

        let geocoder = new MapboxGeocoder({
          accessToken: this.access_token,
          mapboxgl: mapboxgl,
          marker: false,
        });

        this.map.addControl(geocoder);

        // geocoder.on("result", (e) => {
        //   const marker = new mapboxgl.Marker({
        //     draggable: true,
        //     color: "#D80739",
        //   })
        //     .setLngLat(e.result.center)
        //     .addTo(this.map);
        //   this.marker = marker;
        //   this.center = e.result.center;

        //   marker.on("dragend", (e) => {
        //     this.center = Object.values(e.target.getLngLat());
        //   });
        // });
      } catch (err) {
        console.log("map error", err);
      }
    },
    // async getLocation() {
    //   try {
    //     this.loading = true;
    //     const response = await axios.get(
    //       `https://api.mapbox.com/geocoding/v5/mapbox.places/${this.center[0]},${this.center[1]}.json?access_token=${this.access_token}`
    //     );

    //     this.loading = false;
    //     this.location = response.data.features[0].place_name;
    //   } catch (err) {
    //     this.loading = false;
    //     console.log(err);
    //   }
    // },
    // copyLocation() {
    //   if (this.location) {
    //     navigator.clipboard.writeText(this.location);
    //     alert("Location Copied")
    //   }
    //   return;
    // },
    showMarkers({type, data}) {
      // const id = Date.now();
      let color = 'red';
      switch (type) {
        case 'hospitals':
          color = 'blue';
          break;
        case 'clinics':
          color = 'green';
          break;
        default:
          break;
      }
      console.log(this.map.getSource(type));
      if (!this.map.getSource(type)) {
        this.map.addSource(type, {
          // This GeoJSON contains features that include an "icon"
          // property. The value of the "icon" property corresponds
          // to an image in the Mapbox Streets style's sprite.
          'type': 'geojson',
          'data': {
            "type": "FeatureCollection",
            "features": data.features,
          },
        });
              // Add a layer showing the places.
        this.map.addLayer({
          'id': type,
          'type': 'circle',
          'source': type,
          paint: {
            'circle-radius': 10,
            'circle-color': color,
            'circle-stroke-color': 'white',
            'circle-stroke-width': 1,
            'circle-opacity': 0.5
          }
        })
      } else {
        this.map.getSource(type).setData(data);
      }
    },
    setMarker(center) {
      if(this.marker) this.marker.remove();
      const marker = new mapboxgl.Marker({
            draggable: true,
            color: "#D80739",
          })
        .setLngLat(center)
        .addTo(this.map);

        marker.on("dragend", (e) => {
            this.center = Object.values(e.target.getLngLat());
            console.log('center changed welcome', this.center);
          });

      this.marker = marker;
      this.center = center;
      this.map.flyTo({
        center: center,
        speed: 0.2,
    });
    },
  }
}

</script>


<style>
.main {
  display: flex;
}

.map-wrapper {
  position: relative;
  height: 100vh;
  width: 100%;
}
</style>