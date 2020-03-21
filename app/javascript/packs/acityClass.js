class City {
    constructor(name) {
        this.name = name,
        this.fetchURL = `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
    }
}  