<script>
import TheWelcome from "./components/TheWelcome.vue";
import Houses from "./components/Houses.vue";
import AddProperty from "./components/AddProperty.vue";
import Property from "./components/Property.vue"

export default {
  components: {
    TheWelcome,
    Houses,
    AddProperty,
    Property
  },
  data() {
    return {
      showHousesPage: false,
      showAddHouse: false,
      showWelcome: true,
      showOneHouse: false,
      currentHouse: null,
    };
  },
  methods: {
    showHouses() {
      this.showHousesPage = true;
      this.showWelcome = false;
      this.showAddHouse = false;
      this.showOneHouse = false;
    },
    addHouse() {
      this.showAddHouse = true;
      this.showWelcome = false;
      this.showHousesPage = false;
    },
    showHouse(house) {
      this.currentHouse = house;
      this.showAddHouse = false;
      this.showWelcome = false;
      this.showHousesPage = false;
      this.showOneHouse = true;
    }
  }
}
</script>

<template>
  <div id="app">

    <main>
      <TheWelcome v-if='showWelcome' @show-houses="showHouses" @add-house="addHouse"/>
      <Houses v-if='showHousesPage' @add-house="addHouse" @show-house="showHouse">
      </Houses>
      <AddProperty v-if='showAddHouse' @show-houses="showHouses">
      </AddProperty>
      <Property v-if='showOneHouse && currentHouse' :house="currentHouse" @show-houses="showHouses"></Property>

    </main>
  </div>
</template>

<style>
/* width */
::-webkit-scrollbar {
  width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
  box-shadow: inset 0 0 5px grey; 
  border-radius: 10px;
}
 
/* Handle */
::-webkit-scrollbar-thumb {
  background: rgb(109, 109, 109); 
  border-radius: 10px;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: #d1d1d1; 
}
</style>
