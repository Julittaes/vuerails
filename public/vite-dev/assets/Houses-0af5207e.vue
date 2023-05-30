<template>
    <div class="main">
        <div class="sidebar">
            <div class="list-group">
                <a :href="'/properties/' + house.id" class="list-group-item list-group-item-action flex-column align-items-start"  v-for="house in renderedHouses">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">{{ house.title }}</h5>
                        <small class="text-nowrap">{{ house.price }} ￥</small>
                    </div>
                    <small class="text-nowrap">Updated: {{ createdAt(house)}}</small>
                </a>
          </div>
        </div>
        <div class="map-wrapper">
            <div id="map"></div>
        </div>
    </div>
</template>
  
<script>
import axios from "axios";
import initMap from './map.js';

export default {
    data() {
        return {
            houses: [],
            // loading: false,
            // location: "",
            access_token: this.$mapboxApiKey,
            // center: [132.7445942, 35.3665752],
            map: {},
            features: [],
        };
    },

    mounted() {
        this.createMap()
    },

    computed: {
        renderedHouses() {
            return this.houses.filter(item => item.fake_latitude != null)
        },
    },

    methods: {
        createdAt(house) {
            return house.created_at.slice(0, 10);
        },
        async createMap() {
            try {
                this.map = initMap(this.access_token, 'streets');

                axios.get('/properties', {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                    .then(resp => {
                        console.log('response', resp.data);
                        this.houses = JSON.parse(JSON.stringify(resp.data));
                        // console.log('houses', this.houses);
                        this.drawHouses(JSON.parse(JSON.stringify(resp.data)));
                    })
            } catch (err) {
                console.log("map error", err);
            }
        },
        drawHouses(data) {
            const featuresCircles = [];
            const featuresHouses = [];
            data.forEach(house => {
                console.log(house);

                if (house.fake_longitude) {
                    const coord = [house.longitude, house.latitude];
                    featuresHouses.push({
                            "type": "Feature",
                            "geometry": {
                                "type": "Point",
                                "coordinates": coord
                            }
                        });
                    const fakeCoord = [house.fake_longitude, house.fake_latitude];
                    const feature = this.createGeoJSONCircle(fakeCoord, 0.5);
                    featuresCircles.push(feature);
                }
            });
            this.showMarkers('circles', featuresCircles);
            // this.showMarkers('houses', featuresHouses);
        },
        showMarkers(type, data) {
            const thisVue = this;
            this.map.on('load', function () {
                thisVue.map.addSource(type, {
                    // This GeoJSON contains features that include an "icon"
                    // property. The value of the "icon" property corresponds
                    // to an image in the Mapbox Streets style's sprite.
                    'type': 'geojson',
                    'data': {
                        "type": "FeatureCollection",
                        "features": data,
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
                        'circle-radius': 3,
                        'circle-color': 'red'
                    }
                }
                // Add a layer showing the places.
                thisVue.map.addLayer(layerOption);
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