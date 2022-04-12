import * as Vue from "vue"
var id = "#dinamic_table"

if (document.querySelector(id) != null) {
    
    const new_app = Vue.createApp({
        el: id,
        data() {
            return {
                columns: [],
                actions: [],
                data: [],
                search: ""
            }
        },
        methods: {
            async getData() {                
                var search_filter = (this.search == "" || this.search == undefined || this.search == null) ? "" : "?search=" + this.search ;
                var url = '/services/get_list' + search_filter
                
                return await fetch(url, {
                    method: 'GET'
                });
            },
            refresh_data_table(){
                this.getData()
                .then(response => response.json())
                .then( json => {
                    this.columns = json.columns;
                    this.actions = json.actions;
                    this.data = json.data;
                }).catch(error => console.log(error));
            },
            makeSearch() {
                this.search = document.querySelector("#input-search").value
                console.log(this.search)
                this.refresh_data_table()
            },
            async buttonAction(url,type, id) {
                var url = url.replace(':id', id)

                if (type=="render"){
                    window.location.replace(url)
                } else {
                    return await fetch(url).then((response) => {
                        this.refresh_data_table()
                    });
                }
            }
            
        },
        mounted: function() {
            this.refresh_data_table()
        }
    })
    new_app.mount(id)
}