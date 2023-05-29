
import { createApp } from 'vue/dist/vue.esm-bundler';  
import "mapkick/bundle"
import "./assets/main.css";
import 'bootstrap/dist/css/bootstrap.css'

import App from './App.vue'

const app = createApp(App)

app.config.globalProperties.$mapboxApiKey = 'pk.eyJ1IjoiaXJpbmFzayIsImEiOiJjbDIwOHhrbm0wdWJlM2pxZDNvN3A5NHNzIn0.M37Dun7-7tjVc9C0O82lpw'

app.mount('#app');  
console.log("app", app);