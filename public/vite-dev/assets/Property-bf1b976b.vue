<template>
  <div class="main">
    <div class="sidebar col-4 py-3">
      <div>
        <div class="d-flex justify-content-between align-items-center">
          <h2>{{ house.title }}</h2>
          <button class="btn btn-outline-info" @click="$emit('show-houses')">See all houses</button>
        </div>
        <br>
        <h4>General</h4>
        <div class="container text-lg">
          <div class="row my-1">
            <div class="col">
              Price
            </div>
            <div class="col">
              {{ house.price }} ￥
            </div>
          </div>
          <div class="row my-1">
            <div class="col">
              Rooms
            </div>
            <div class="col">
              {{ house.rooms }}
            </div>
          </div>
          <div class="row my-1">
            <div class="col">
              Bathrooms
            </div>
            <div class="col">
              {{ house.bathrooms }}
            </div>
          </div>
        </div>
        <br>
        <h4>Location</h4>
        <Rating :count="count" />
        <br>
        <h5>Owner</h5>
        Asakura Yo
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
import Rating from "./Rating.vue";
import SearchButton from "./searchButton.vue"

export default {
  props: ['house'],
  components: {
    AddPropertyForm,
    Search,
    Rating,
    SearchButton
  },
  data() {
    return {
      loading: false,
      location: "",
      access_token: this.$mapboxApiKey,
      currentLocation: [],
      map: {},
      rating: 6,
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
    this.createMap()
  },

  methods: {
    async createMap() {
      try {
        mapboxgl.accessToken = this.access_token;

        let options = {
          container: 'map',
          style: 'mapbox://styles/mapbox/streets-v12',
          zoom: 12,
          center: [132.7445942, 35.3665752]
        };

        this.map = new mapboxgl.Map(options);

        const fakeCoord = [this.house.fake_longitude, this.house.fake_latitude];
        const feature = this.createGeoJSONCircle(fakeCoord, 0.5);
        const featuresCircles = [feature];
        this.showMarkers({type:'circles', data:{features: featuresCircles}});
        console.log('init');
        this.currentLocation = [this.house.longitude, this.house.latitude];
        this.search();

      } catch (err) {
        console.log("map error", err);
      }
    },
    countMarkers(event) {
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
    },
    showMarkers({ type, data }) {
        this.countMarkers({type: type, data: data});
      let color = 'pink';
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
      const thisVue = this;
      this.map.on('load', function () {
        if (!thisVue.map.getSource(type)) {
          thisVue.map.addSource(type, {
            // This GeoJSON contains features that include an "icon"
            // property. The value of the "icon" property corresponds
            // to an image in the Mapbox Streets style's sprite.
            'type': 'geojson',
            'data': {
              "type": "FeatureCollection",
              "features": data.features,
            },
          });
          const layerOption = type === 'circles' ? 
                {
                    'id': type,
                    'type': 'fill',
                    'source': type,
                    paint: {
                        "fill-color": "blue",
                        "fill-opacity": 0.6
                    }
                } :
                {
                    'id': type,
                    'type': 'circle',
                    'source': type,
                    paint: {
                        'circle-radius': 10,
                        'circle-color': color,
                        'circle-opacity': 0.5
                    }
                }
                // Add a layer showing the places.
                thisVue.map.addLayer(layerOption);
        } else {
          thisVue.map.getSource(type).setData(data);
        }
      })
    },
    createGeoJSONCircle(center, radiusInKm, points) {
      if (!points) points = 64;

      var coords = {
        latitude: center[1],
        longitude: center[0]
      };

      var km = radiusInKm;

      var ret = [];
      var distanceX = km / (111.320 * Math.cos(coords.latitude * Math.PI / 180));
      var distanceY = km / 110.574;

      var theta, x, y;
      for (var i = 0; i < points; i++) {
        theta = (i / points) * (2 * Math.PI);
        x = distanceX * Math.cos(theta);
        y = distanceY * Math.sin(theta);

        ret.push([coords.longitude + x, coords.latitude + y]);
      }
      ret.push(ret[0]);

      return {
        "type": "Feature",
        "geometry": {
          "type": "Polygon",
          "coordinates": [ret]
        }
      }
    },
    search() {
      const minX = parseFloat(this.currentLocation[0]) - 0.02;
        const minY = parseFloat(this.currentLocation[1]) - 0.02;
        const maxX = parseFloat(this.currentLocation[0]) + 0.02;
        const maxY = parseFloat(this.currentLocation[1]) + 0.02;
        const bboxString = `bbox=${minX},${minY},${maxX},${maxY}`;
        console.log(this.currentLocation);
        console.log(bboxString);
        console.log(this.currentLocation);
        axios.get(`https://api.mapbox.com/search/v1/forward/クリニック?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.access_token}`)
        .then((response) => {
            console.log(response.data);
            this.showMarkers({type: 'clinics', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/生活>小学校?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.access_token}`)
        .then((response) => {
            console.log(response.data);
            this.showMarkers({type: 'elemSchools', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/医療>病院?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.access_token}`)
        .then((response) => {
            console.log(response.data);
            this.showMarkers({type:'hospitals', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/ショップ>コンビニ?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.access_token}`)
        .then((response) => {
            console.log(response.data);
            this.showMarkers({type:'konbini', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/生活>幼稚園?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.access_token}`)
        .then((response) => {
            console.log(response.data);
            this.showMarkers({type:'kindergardens', data: response.data});
        })
    }
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
  /* width: 500px; */
}
</style>