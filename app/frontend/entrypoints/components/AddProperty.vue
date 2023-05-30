<template>
    <form ref="form" @submit.prevent="submit">
        <div class="form-group">
            <label for="formGroupExampleInput">Title</label>
            <input type="text" class="form-control" id="formGroupExampleInput" name="property[title]">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Address</label>
            <input type="text" class="form-control" id="formGroupExampleInput2" name="property[address]">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Price（￥）</label>
            <input type="number" class="form-control" id="Price" name="property[price]">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Rooms</label>
            <input type="number" class="form-control" id="Rooms" name="property[rooms]">
        </div>
        <div class="form-group">
            <label for="formGroupExampleInput2">Bathrooms</label>
            <input type="number" class="form-control" id="Bathrooms" name="property[bathrooms]">
        </div>
        <div class="form-group">
            <label for="exampleFormControlFile1">Photo</label>
            <input type="file" class="form-control-file" id="exampleFormControlFile1" multiple name="property[avatar]">
        </div>
        <input type="hidden" id="account_i" name="property[account_id]" value="3" />
        <input type="hidden" id="account_i" name="property[latitude]" :value="latitude"/>
        <input type="hidden" id="account_i" name="property[longitude]" :value="longitude"/>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</template>
  
<script>
import axios from "axios";

export default {
    props: ['latitude', 'longitude'],
    methods: {
        submit(){
            const form = this.$refs.form;
            const formData = new FormData(form);
            axios.post('/properties', formData);
        }
    }
}

</script>
  
  
<style>

</style>