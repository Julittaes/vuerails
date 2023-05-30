<template>
  <div class="main">
    <div class="sidebar col-4 py-3">
      <div>
        <div class="d-flex justify-content-between align-items-center">
          <h2>Add house</h2>
          <button class="btn btn-outline-info" @click="$emit('show-houses')">See all houses</button>
        </div>

        <h3>General</h3>
        <AddPropertyForm ref="form" :latitude="center[1]" :longitude="center[0]" :location="location" :rating="rating" @show-houses="$emit('show-houses')"/>
        <Search :map="map" :center="center" @set-marker='setMarker' @found-places="showMarkers"
          @location-input="locationInput" @rating-update="ratingUpdate"/>
        <button type="submit" class="btn btn-primary btn-lg btn-block mt-3" @click="submitForm">Submit</button>
      </div>
    </div>
    <div class="map-wrapper">
      <div id="map"></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import "@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css";
import initMap from './map.js';
import AddPropertyForm from './AddPropertyForm.vue';
import Search from "./Search.vue";

export default {
  components: {
    AddPropertyForm,
    Search
  },
  data() {
    return {
      loading: false,
      location: "",
      access_token: this.$mapboxApiKey,
      center: [132.7445942, 35.3665752],
      map: {},
      rating: 6,
    };
  },

  mounted() {
    this.createMap()
  },

  methods: {
    ratingUpdate(value) {
      this.rating = value;
    },
    locationInput(value) {
      this.location = value;
    },
    async createMap() {
      try {
        this.map = initMap(this.access_token, "streets");

        let geocoder = new MapboxGeocoder({
          accessToken: this.access_token,
          mapboxgl: mapboxgl,
          marker: false,
        });

      } catch (err) {
        console.log("map error", err);
      }
    },
    submitForm() {
      this.$refs.form.submit();
    },
    showMarkers({ type, data }) {
      console.log('addproperty');
      let color = 'magneta';
      switch (type) {
        case 'hospitals':
          color = 'red';
          break;
        case 'konbini':
          color = 'yellow';
          break;
        case 'elemSchools':
          color = 'blue';
          break;
        case 'clinics':
          color = 'green';
          break;
        case 'kindergardens':
          color = '#17a2b8';
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
      if (this.marker) this.marker.remove();
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


<style scoped>
.main {
  display: flex;
  height: 100vh;
}

.map-wrapper {
  position: relative;
  height: 100vh;
  width: 100%;
}

.sidebar {
  overflow-y: auto;
}
</style>