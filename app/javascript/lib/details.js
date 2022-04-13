import * as Vue from "vue"
var id = "#details"

if (document.querySelector(id) != null) {

    const new_app = Vue.createApp({
        el: id,
        data() {
            return {
                editable: false,
                days: ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
                // service_hours: [],
                headers: [],
                data: []
            }
        },
        methods: {
            async getData(shift_type) {
                console.log("get_data")
                var url = '/get_shifts/' + shift_type

                return await fetch(url, {
                    method: 'GET'
                });
            },

            toggleChecked(event, day, hour, index) {
                event.target.toggleAttribute('checked')
                this.data[day][hour][index] = event.target.hasAttribute('checked')
                console.log(this.data[day])
            },
            changeTab(event) {
                var tab = event.target.attributes['data-bs-target'].value;
                document.querySelectorAll(".tab-pane").forEach(element=>{
                    element.setAttribute("style", "display: none")
                })
                document.querySelector(tab).setAttribute("style", "display: block")
            },
            makeEditable() {
                document.querySelectorAll("input[type='checkbox']").forEach(element => {
                    element.removeAttribute("disabled")
                })
                this.editable = true;
            },
            async SaveChanges() {
                await fetch('/shifts/modify_all/', {
                    method: 'POST',
                    body: JSON.stringify(
                        this.data
                    )
                })
                .then(response => response.json())
                .then(json => {
                    this.editable = false;
                    document.querySelectorAll("input[type='checkbox']").forEach(element => {
                        element.setAttribute("disabled", true)
                    })
                }).catch(error => console.log(error));
            },
            mark_checked() {
                console.log(document.querySelectorAll("input[type='checkbox'][data-checked=true]"))
                document.querySelectorAll("input[type='checkbox'][data-checked=true]").forEach(element => {
                    element.setAttribute("checked", true)
                })
                
            }
        },
        mounted: function () {
            this.getData("availability")
            .then(response => response.json())
            .then(json => {
                this.data = json.data;
                this.headers = json.header;
            })
            .then( json => {
                this.mark_checked();
            }).catch(error => console.log(error));
            
        }
    })
    new_app.mount(id)
}