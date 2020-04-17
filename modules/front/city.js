class City {
    constructor(id, fetchURL, name) {

        this.id = id
        this.fetchURL = fetchURL || `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
        this.name = name || this.setName(name)
    }

    setName(name) {
        if (name && name.match(/\w+\W\w+/)) {
            //this will never run as  if name exists it will be set before 
            return name
        }
        else {
            let parsed = this.fetchURL.match(/=\w+\W\w+,|=\w+,/);
            return parsed[0].slice(1, parsed[0].length - 1)

        }
    }

}




//this is an epoc converter
//new Date(ob