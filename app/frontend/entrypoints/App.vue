<script>
import TheWelcome from "./components/TheWelcome.vue";
import Houses from "./components/Houses.vue";
import AddProperty from "./components/AddProperty.vue";

export default {
  components: {
    TheWelcome,
    Houses,
    AddProperty
  },
  data() {
    return {
      showHousesPage: false,
      showAddHouse: false,
      showWelcome: true
    };
  },
  methods: {
    showHouses() {
      this.showHousesPage = true;
      this.showWelcome = false;
      this.showAddHouse = false;
    },
    addHouse() {
      this.showAddHouse = true;
      this.showWelcome = false;
      this.showHousesPage = false;
    },
  }
}
</script>

<template>
  <div id="app">

    <main>
      <TheWelcome v-if='showWelcome' @show-houses="showHouses" @add-house="addHouse"/>
      <Houses v-if='showHousesPage' @add-house="addHouse">
      </Houses>
      <AddProperty v-if='showAddHouse' @show-houses="showHouses">
      </AddProperty>

    </main>
  </div>
</template>

<style scoped></style>
