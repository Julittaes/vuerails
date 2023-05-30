<template>
  <div class="sidebar p-1">
    <!-- Coordinates Display here -->
    <div class="dislpay-arena">
      <div class="coordinates-header">
        <h3>Current Coordinates</h3>
        <p>Latitude: {{ center[0] }}</p>
        <p>Longitude: {{ center[1] }}</p>
      </div>

      <div class="coordinates-header">
        <h3>Enter my address:</h3>

        <div class="form-group">
          <input type="text" class="form-control location-control my-1" v-model="location"
            @input="event => addressEdited = true" />
          <button v-if="addressEdited" type="button" class="btn btn-info" @click="searchLngLat">
            Show on the map!
          </button>
          <!-- <button type="button" :disabled="loading" :class="{ disabled: loading }" class="location-btn"
            @click="getLocation">
            Get Location
          </button> -->
          <button type="button" v-if="locationFound && !addressEdited" :disabled="loading" :class="{ disabled: loading }"
            class="btn btn-info mx-1" @click="toggleEditPosition">
            {{ btnEditPositionText }}
          </button>
          <p v-if="editPositionFlg">Move marker</p>
        </div>
        <SearchButton v-if="locationFound" :access-token="access_token" :current-location="center"
          @found-places="showMarkers" />
        <p v-if="locationFound">
          elementary school red
          hospital blue
          clinics green
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import "@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css";
import SearchButton from './searchButton.vue';
import AddProperty from "./AddProperty.vue";

export default {
  props: ['map', 'center'],
  components: {
    SearchButton,
    AddProperty
  },
  data() {
    return {
      loading: false,
      location: "",
      access_token: this.$mapboxApiKey,
      // center: this.currentCenter,
      marker: false,
      editPositionFlg: false,
      locationFound: false,
      addressEdited: true,
    };
  },

  mounted() {
    this.init()
  },
  // watch: {
  //   currentCenter(newCenter) {
  //     console.log('new center');
  //       this.center = newCenter;
  //   }
  // },
  computed: {
    btnEditPositionText() {
      return this.editPositionFlg ? 'Save new position' : 'Adjust position'
    }
  },

  methods: {
    toggleEditPosition() {
      if (this.editPositionFlg) {

      }
      this.editPositionFlg = !this.editPositionFlg;
    },
    async init() {
      try {

        let geocoder = new MapboxGeocoder({
          accessToken: this.access_token,
          mapboxgl: mapboxgl,
          marker: false,
        });

        // this.map.addControl(geocoder);

        // geocoder.on("result", (e) => {
        //   const marker = new mapboxgl.Marker({
        //     draggable: true,
        //     color: "#D80739",
        //   })
        //     .setLngLat(e.result.center)
        //     .addTo(this.map);
        //   this.center = e.result.center;

        //   marker.on("dragend", (e) => {
        //     this.center = Object.values(e.target.getLngLat());
        //   });
        // });
      } catch (err) {
        console.log("map error", err);
      }
    },
    async getLocation() {
      try {
        this.loading = true;
        console.log(this.center);
        const response = await axios.get(
          `https://api.mapbox.com/geocoding/v5/mapbox.places/${this.center[0]},${this.center[1]}.json?access_token=${this.access_token}&language=ja`
        );

        this.loading = false;
        // this.$emit('set-location', this.center);
        // this.setLocation(response.data.features[0].place_name);
        if (response.data.features.length == 0) throw Error('not found!');
        this.location = response.data.features[0].place_name;
      } catch (err) {
        this.loading = false;
        console.log(err);
        if (err.message === 'not found!') console.log('not found!')
      }
    },
    async searchLngLat() {
      console.log('click');
      if (this.location) {
        this.loading = true;
        axios.get(
          `https://api.mapbox.com/geocoding/v5/mapbox.places/${this.location}.json?proximity=ip&access_token=${this.access_token}&language=ja`
        )
          .then(response => {
            this.loading = false;
            if (response.data.features.length === 0) throw Error('not found');
            // this.center = response.data.features[0].center;
            // this.setMarker(response.data.features[0].center);
            this.$emit('set-marker', response.data.features[0].center);
            this.locationFound = true;
            this.addressEdited = false;
          })
          .catch(err => {
            this.locationFound = false;
            if (err.message == 'not found') console.log('not found')
            console.log(err);
          })
      }
      return;
    },
    showMarkers(event) {
      this.$emit('found-places', event);
    }
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

.sidebar {
  width: 400px;
  height: 100vh;
}
</style>