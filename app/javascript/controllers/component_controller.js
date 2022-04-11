import * as Vue from "vue"

if (document.querySelector("#hello") != null) {
    const new_app = Vue.createApp({
        el: '#hello',
        data() {
            return {
                message: "Can you say hello?"
            }
        }
    })
    new_app.mount("#hello")
}