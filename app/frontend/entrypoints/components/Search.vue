<template>
  <!-- Coordinates Display here -->
  <div class="dislpay-arena">
    <div class="coordinates-header">
      <h3>Location</h3>
      <span class="font-italic">Your address will not be displayed to others.</span>
      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" class="form-control location-control my-2" id="address" v-model="location"
          @input="locationInput" />
        <button v-if="addressEdited" type="button" class="btn btn-outline-info" @click="searchLngLat">
          Show my house on the map!
        </button>
        <!-- <button type="button" :disabled="loading" :class="{ disabled: loading }" class="location-btn"
            @click="getLocation">
            Get Location
          </button> -->

        <button type="button" v-if="locationFound && !addressEdited" :disabled="loading" :class="{ disabled: loading }"
          class="btn btn-outline-info m-1" @click="toggleEditPosition">
          {{ btnEditPositionText }}
        </button>
        <span class="ml-1 font-italic" v-if="editPositionFlg">Move marker</span>
      </div>
      <h4>Places nearby</h4>
      <p class="font-italic">Check you location rating!</p>
      <SearchButton :disabled="!locationFound || addressEdited" :access-token="access_token" :current-location="center"
        @found-places="showMarkers" />
        <div v-if="locationFound && searchedFlg && !addressEdited">
      <Rating :count="count"/>
    </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import "@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css";
import SearchButton from './searchButton.vue';
import Rating from "./Rating.vue";

export default {
  props: ['map', 'center'],
  components: {
    SearchButton,
    Rating,
  },
  data() {
    return {
      loading: false,
      location: "",
      access_token: this.$mapboxApiKey,
      // center: this.currentCenter,
      marker: false,
      editPositionFlg: false,
      searchedFlg: false,
      locationFound: false,
      addressEdited: true,
      count: {
        clinics: 0,
        hospitals: 0,
        elementarySchools: 0,
        konbini: 0,
        kindergardens: 0
      }
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
    },
    rating() {
      let sum = 0;
      for (const property in this.count) {
        sum = sum + this.count[property];
      }
      if (sum >= 40) return 10;
      return 6 + sum/10;
    }
  },

  methods: {
    locationInput(event) {
      this.addressEdited = true
      this.$emit('location-input', event.target.value);
    },
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
      console.log('click', this.location);
      if (this.location) {
        this.loading = true;
        axios.get(
          `https://api.mapbox.com/geocoding/v5/mapbox.places/${this.location}.json?proximity=ip&access_token=${this.access_token}&language=ja`
        )
          .then(response => {
            console.log('answer');
            this.loading = false;
            if (response.data.features.length === 0) throw Error('not found');
            // this.center = response.data.features[0].center;
            // this.setMarker(response.data.features[0].center);
            this.$emit('set-marker', response.data.features[0].center);
            this.locationFound = true;
            this.addressEdited = false;
          })
          .catch(err => {
            console.log('err');
            this.locationFound = false;
            if (err.message == 'not found') console.log('not found')
            console.log(err);
          })
      }
      return;
    },
    showMarkers(event) {
      console.log("found-places search", event);
      this.searchedFlg = true;
      switch (event.type) {
        case 'clinics':
          this.count.clinics = event.data.features.length;
          break;
        case 'hospitals':
          this.count.hospitals = event.data.features.length;
          break;
        case 'elemSchools':
          this.count.elemSchools = event.data.features.length;
          break;
        case 'konbini':
          this.count.konbini = event.data.features.length;
          break;
        case 'kindergardens':
          this.count.kindergardens = event.data.features.length;
          break;
      }
      this.$emit('found-places', event);
      this.$emit('rating-update', this.rating);
    }
  }
}

</script>


<style scoped>
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