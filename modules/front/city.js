class City {
    constructor(id, fetchURL, name) {
        this.id = id || 1000
        this.fetchURL = fetchURL || `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
        this.name = name || this.setGetName()
    }
    //not using set or get because it's more code to write two methods vs one 
    debugger
    setGetName() {
            let parsed = this.fetchURL.match(/=\w+\W\w+,|=\w+,/);
            return parsed[0].slice(1, parsed[0].length - 1)
     }

}


