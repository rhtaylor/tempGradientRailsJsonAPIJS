class City {
    constructor(name, id, fetchURL) {
        this.name = name
        this.id = id
        this.fetchURL = fetchURL || `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=${gon.key}`

    }


}