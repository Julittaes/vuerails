<template>
  <button class="btn btn-info"  @click="search">Search places nearby</button>
</template>

<script>
import axios from "axios";

export default {
  props: ['current-location','access-token'],

  methods: {
    search() {
      const minX = parseFloat(this.currentLocation[0]) - 0.02;
        const minY = parseFloat(this.currentLocation[1]) - 0.02;
        const maxX = parseFloat(this.currentLocation[0]) + 0.02;
        const maxY = parseFloat(this.currentLocation[1]) + 0.02;
        const bboxString = `bbox=${minX},${minY},${maxX},${maxY}`;
        console.log(this.currentLocation);
        console.log(bboxString);
        console.log(this.currentLocation);
        axios.get(`https://api.mapbox.com/search/v1/forward/クリニック?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.accessToken}`)
        .then((response) => {
            console.log(response.data);
            this.$emit('found-places', {type: 'clinics', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/生活>小学校?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.accessToken}`)
        .then((response) => {
            console.log(response.data);
            this.$emit('found-places', {type: 'elemSchools', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/医療>病院?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.accessToken}`)
        .then((response) => {
            console.log(response.data);
            this.$emit('found-places',{type:'hospitals', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/ショップ>コンビニ?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.accessToken}`)
        .then((response) => {
            console.log(response.data);
            this.$emit('found-places',{type:'konbini', data: response.data});
        })
        axios.get(`https://api.mapbox.com/search/searchbox/v1/category/生活>幼稚園?language=ja&limit=10&${bboxString}&proximity=${this.currentLocation[0]},${this.currentLocation[1]}&country=JP&access_token=${this.accessToken}`)
        .then((response) => {
            console.log(response.data);
            this.$emit('found-places',{type:'kindergardens', data: response.data});
        })
    }
  }
}
</script>

<style scoped>
</style>
