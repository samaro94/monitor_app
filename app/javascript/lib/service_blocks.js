import * as Vue from "vue"
var id = "#edit_blocks"

if (document.querySelector(id) != null) {

    const new_app = Vue.createApp({
        el: id,
        data() {
            return {
                service_id: "",
                blocks: {
                    monday: {
                        from: "",
                        to: ""
                    },
                    tuesday: {
                        from: "",
                        to: ""
                    },
                    wednesday: {
                        from: "",
                        to: ""
                    },
                    thursday: {
                        from: "",
                        to: ""
                    },
                    friday: {
                        from: "",
                        to: ""
                    },
                    saturday: {
                        from: "",
                        to: ""
                    },
                    sunday: {
                        from: "",
                        to: ""
                    }
                }
            }
        },
        methods: {
            loadServiceId() {
                var url_arr = window.location.href.split("/")
                this.service_id = url_arr[url_arr.length-1]
            },
            async getBlocks() {
                var url = '/service_blocks?service_id=' + this.service_id
                return await fetch(url, {
                    method: 'GET'
                });
            },
            async sendData() {
                var url = '/service_blocks/update/' + this.service_id

                return await fetch(url, {
                    method: 'POST',
                    body: JSON.stringify( 
                        this.blocks
                    )
                });
            }

        },
        mounted: function () {
            this.loadServiceId();
            this.getBlocks()
            .then(response => response.json())
            .then(json => {
                this.blocks = json;
            }).catch(error => console.log(error));
        }
    })
    new_app.mount(id)
}