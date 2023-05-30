<template>
    <form ref="form" @submit.prevent.stop>
        <div class="form-group">
            <label for="formGroupExampleInput">Title</label>
            <input type="text" class="form-control" id="formGroupExampleInput" name="property[title]" required>
        </div>
        <div class="row">
            <div class="form-group col-6">
                <label for="formGroupExampleInput2">Price（￥）</label>
                <input type="number" class="form-control" id="Price" name="property[price]" required>
            </div>
            <div class="form-group col-3">
                <label for="formGroupExampleInput2">Rooms</label>
                <input type="number" class="form-control" id="Rooms" name="property[rooms]" required>
            </div>
            <div class="form-group col-3">
                <label for="formGroupExampleInput2">Bathrooms</label>
                <input type="number" class="form-control" id="Bathrooms" name="property[bathrooms]" required>
            </div>
        </div>
        <div class="form-group">
            <label for="exampleFormControlFile1">Photo</label>
            <input type="file" class="form-control-file" id="exampleFormControlFile1" multiple name="property[avatar]">
        </div>
        <input type="hidden" name="property[latitude]" :value="latitude"/>
        <input type="hidden" name="property[longitude]" :value="longitude"/>
        <input type="hidden" name="property[address]" :value="location"/>
        <input type="hidden" name="property[rating]" :value="rating"/>
    </form>
</template>
  
<script>
import axios from "axios";

export default {
    props: ['latitude', 'longitude', 'location', 'rating'],
    methods: {
        submit(){
            const thisVue = this;
            const form = this.$refs.form;
            const formData = new FormData(form);
            axios.post('/properties', formData)
            .then(res => thisVue.$emit('show-houses'))
            .catch(err => console.log(err))
        }
    }
}

</script>
  
  
<style>

</style>