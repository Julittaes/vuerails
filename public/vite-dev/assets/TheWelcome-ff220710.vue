<template>
  <div class="main">
    <div class="map-wrapper">
      <div id="map"></div>
      <button class="btn btn-lg mt-5 ml-5 text-white border border-light glow-on-hover" id="fly" style="background-color: transparent;">Let's go Izumo!</button>
    </div>
    <Modal v-if="showModal" @close="showModal = false" @show-houses="showHouses" @add-house="addHouse"/>
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
      showModal: false,
    };
  },

  mounted() {
    this.createMap()
  },

  methods: {
    showHouses() {
      this.$emit('show-houses');
    },
    addHouse() {
      this.$emit('add-house');
    },
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
      const thisVue = this;
      setTimeout(() => {
        thisVue.showModal = true;
      }, 2000);
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

/* .zoom-ani {
  animation: zoom-in-zoom-out 1s ease infinite;
}

@keyframes zoom-in-zoom-out {
  0% {
    transform: scale(1, 1);
  }
  50% {
    transform: scale(1.1, 1.1);
  }
  100% {
    transform: scale(1, 1);
  }
} */

.glow-on-hover {
    width: 220px;
    height: 50px;
    border: none;
    outline: none;
    color: #fff;
    /* background: #111; */
    cursor: pointer;
    position: relative;
    z-index: 0;
    border-radius: 10px;
}
.glow-on-hover:hover {
  color: #000;
}

.glow-on-hover:before {
    content: '';
    background: linear-gradient(45deg, #ff0000, #ff7300, #fffb00, #48ff00, #00ffd5, #002bff, #7a00ff, #ff00c8, #ff0000);
    position: absolute;
    top: -2px;
    left:-2px;
    background-size: 400%;
    z-index: -1;
    filter: blur(5px);
    width: calc(100% + 4px);
    height: calc(100% + 4px);
    animation: glowing 20s linear infinite;
    opacity: 0;
    transition: opacity .3s ease-in-out;
    border-radius: 10px;
}

.glow-on-hover:active {
    color: #000
}

.glow-on-hover:active:after {
    background: transparent;
    color: #111;
}

.glow-on-hover:hover:before {
    opacity: 1;
}

.glow-on-hover:after {
    z-index: -1;
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    /* background: #111; */
    left: 0;
    top: 0;
    border-radius: 10px;
}

@keyframes glowing {
    0% { background-position: 0 0; }
    50% { background-position: 400% 0; }
    100% { background-position: 0 0; }
}
</style>