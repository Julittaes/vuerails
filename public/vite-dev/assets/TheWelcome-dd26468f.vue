<template>
  <div class="main">
    <div class="map-wrapper">
      <div id="map"></div>
      <button class="btn btn-light m-1" id="fly">Let's go Izumo!</button>
    </div>
    <Modal />
  </div>
</template>

<script>
import "@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css";
import initMap from './map.js';
import Modal from './Modal.vue'

export default {
  components: {
    Modal
  },
  data() {
    return {
      access_token: this.$mapboxApiKey,
      map: {},
    };
  },

  mounted() {
    this.createMap()
  },

  methods: {
    async createMap() {
      try {
        this.map = initMap(this.access_token, "globe", this.flyended);
        const izumo = {
            center: [132.7445942, 35.3665752],
            zoom: 12.5,
            bearing: 90,
            pitch: 80
        };

        const thisVue = this;
        document.getElementById('fly').addEventListener('click', () => {
        // depending on whether we're currently at point a or b,
        // aim for point a or b
        // const target = isAtStart ? end : start;
        // isAtStart = !isAtStart;

        thisVue.map.flyTo({
                ...izumo, // Fly to the selected target
                duration: 5000, // Animate over 12 seconds
                essential: true // This animation is considered essential with
                //respect to prefers-reduced-motion
            });

            event.target.style.display = 'none';
        });
      } catch (err) {
        console.log("map error", err);
      }
    },
    flyended() {
      console.log('ended!');
      document.querySelector('#exampleModalCenter').modal('show');
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
</style>