import Vue from 'vue'
import App from './App.vue'
//router must be smalle letter , not Router
//If ruter Capital letter, found this error "Cannot read property 'matched' of undefined"
import router from './router/index'

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
