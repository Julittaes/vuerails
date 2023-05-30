<template>
    <p class="mt-1">
        <span class="text-lg badge badge-primary m-1">elementary schools: {{ count.elemSchools }}</span>
        <!-- <span class="badge badge-secondary">Secondary</span>-->
          <span class="text-lg badge badge-warning m-1">konbini: {{ count.konbini }}</span>
        <span class="text-lg badge badge-danger m-1">hospitals: {{ count.hospitals }}</span>
        <span class="text-lg badge badge-success m-1">clinics: {{ count.clinics }}</span>
        <span class="text-lg badge badge-info m-1">kindergardens: {{ count.kindergardens }}</span>
        <!-- <span class="badge badge-info">Info</span>
          <span class="badge badge-light">Light</span>
          <span class="badge badge-dark">Dark</span> -->
      </p>
      <h6>Average rating: {{ rating }} / 10</h6>
</template>

<script>
export default {
    props: ['count'],
    computed: {
    rating() {
      let sum = 0;
      for (const property in this.count) {
        sum = sum + this.count[property];
      }
      if (sum >= 40) return 10;
      return 6 + sum/10;
    }
  },
  
}
</script>