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
      showAddHouse: true,
      showWelcome: false
    };
  },
  methods: {
    showHouses() {
      this.showHousesPage = true;
      this.showWelcome = false;
    },
    addHouse() {
      this.showAddHouse = true;
      this.showWelcome = false;
    },
  }
}
</script>

<template>
  <div id="app">
    <!-- <header>
      <a href="/properties/new">New</a>
    </header> -->

    <main>
      <TheWelcome v-if='showWelcome' @show-houses="showHouses" @add-house="addHouse"/>
      <Houses v-if='showHousesPage'/>
      <AddProperty v-if='showAddHouse'/>
    </main>
  </div>
</template>

<style scoped></style>
