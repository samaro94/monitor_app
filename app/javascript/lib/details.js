import * as Vue from "vue"
var id = "#details"

if (document.querySelector(id) != null) {

    const new_app = Vue.createApp({
        el: id,
        data() {
            return {
                editable: false,
                tabs: [],
                // days: ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
                // service_hours: [],
                headers: [],
                data: []
            }
        },
        methods: {
            async getData(shift_type) {
                var url = '/get_shifts/' + shift_type + window.location.search

                return await fetch(url, {
                    method: 'GET'
                });
            },

            toggleChecked(event, day, hour, index) {
                event.target.toggleAttribute('checked')
                this.data[day][hour][index] = event.target.hasAttribute('checked')
            },
            changeTab(event) {
                var tab = event.target.attributes['data-bs-target'].value;
                document.querySelectorAll(".tab-pane").forEach(element=>{
                    element.setAttribute("style", "display: none")
                })
                document.querySelector(tab).setAttribute("style", "display: block")

                document.querySelectorAll(".nav-link").forEach(element=>{
                    element.classList.remove("selected")
                })
                event.target.classList.add("selected")
            },
            async setToEdit(){
                this.editable = true
                return true
            },
            makeEditable() {
                // document.querySelectorAll("input[type='checkbox']").forEach(element => {
                //     element.removeAttribute("disabled")
                // })
                // (
                this.setToEdit().then(() => {
                    document.querySelectorAll("input[type='checkbox'][data-checked=true]").forEach(element => {
                        element.setAttribute("checked", true)
                    })
                })
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
                    // document.querySelectorAll("input[type='checkbox']").forEach(element => {
                    //     element.setAttribute("disabled", true)
                    // })
                }).catch(error => console.log(error));
            },
            mark_checked() {
                var tabs_content = document.querySelectorAll(".tab-pane")
                tabs_content.forEach(element => {
                    if (element != tabs_content[0]){
                        element.setAttribute("style", "display: none")
                    }
                })
            }
        },
        mounted: function () {
            var shift_type = document.querySelector(id).getAttribute("data-type")
            this.getData(shift_type)
            .then(response => response.json())
            .then(json => {
                this.data = json.data;
                this.headers = json.header;
                this.tabs = Object.keys(json.data);
                console.log(json.data)
            })
            .then( json => {
                this.mark_checked();
            }).catch(error => console.log(error));
            
        }
    })
    new_app.mount(id)
}