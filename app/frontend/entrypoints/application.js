
import { createApp } from 'vue/dist/vue.esm-bundler';  
import "mapkick/bundle"
  
const app = createApp({  
  data() {  
    return {  
      course: 'Intro to Vue 3 and Rails'  
    }  
  }  
})  
  
app.mount('#app');  
console.log("app", app);  