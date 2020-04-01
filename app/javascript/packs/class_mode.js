const BASE_URL = "http://localhost:3000/cities.json"
const POST_BASE_URL = "http://localhost:3000/cities/"
const TEMP_URL = "http://localhost:3000/cities/temps/diff.json"
document.addEventListener("DOMContentLoaded", function (event) {
    DOMWorker.buildDOM();
    FetchData.fetchCityData();
    //timeIntervalcallback();
    document.addEventListener("click", function (e) {
        e.preventDefault()
        e.target.matches("#green") ? FetchData.postData() : console.log("Not Here");
        e.target.matches("#button2") ? FetchData.fetchTempDiff() : console.log("Try again");
        e.target.matches("#aboutButton") ? DOMWorker.about() : console.log("not here either");
    });
});
class DOMWorker {
    constructor() {

    }
    static about() { 
        
        main.removeChild(document.getElementById("fetched"));
        
        const about = document.getElementById("fetched") || document.createElement("div"); 
        about.setAttribute("id", "fetched")
        const h2 = document.createElement("h2") 
        h2.innerText = "ABOUT:"
        const p = document.createElement("p");
        const p2 = document.createElement("p");
        const p3 = document.createElement("p");
        const p4 = document.createElement("p");
        const p5 = document.createElement("p");
        const p6 = document.createElement("p");
        p.innerText = "Boiling Forest is brought to you from the mind of a conscientious citizen."
        p2.innerText = "Randall Taylor graduated from the University of Arizona with  BS in Physiology, minor in Biochemistry,"
        p3.innerText = "and second minor in business administration. With a strong interest in science he always had a full "
        p4.innerText = "mind of scientific and engineering ideas."
        const abstract = document.createElement("h2");
        abstract.innerText = "ABSTRACT:"
        const p7 = document.createElement("p");
        p7.innerText = "Global warming is largely considered fact in the scientific community.The pumping of CO2 into the air by way of capitalistic"
        const p8 = document.createElement("p")
        p8.innerText = "societies have given rise to a blanket of gas.This gas traps radiation from the sun and hold onto that energy longer.It should be shown"
        const p9 = document.createElement("p")
        p9.innerText = "that the earth takes longer to cool after the sun has set over time.This application aims to track this temperature to ascertain if and to what degree this is happening."
        about.appendChild(h2)
        about.appendChild(p);
        about.appendChild(p2);
        about.appendChild(p3);
        about.appendChild(p4);
        about.appendChild(p5);
        about.appendChild(p6);
        about.appendChild(abstract)
        about.appendChild(p7);
        about.appendChild(p8);
        about.appendChild(p9);
        main.appendChild(about);
    }
    static buildDOM() {
        console.log("buildDOM is running")
        const main = document.getElementById("main");
        const newDiv = document.getElementById("fetched") || document.createElement("div");
        newDiv.setAttribute("id", "fetched");
        const button = document.createElement("button");
        const aboutButton = document.createElement("button");
        aboutButton.innerText = "About";
        aboutButton.setAttribute("id", "aboutButton");
        button.setAttribute("id", "green");
        button.setAttribute("class", "button")
        button.innerText = "Display Current Temps"
        const button2 = document.createElement("button");
        button2.innerText = "Display Temp Decrease Rate ";
        button2.setAttribute("id", "button2");
        button2.setAttribute("class", "button")
        main.appendChild(aboutButton);
        main.appendChild(button);
        main.appendChild(button2);
        main.appendChild(newDiv);
    }
    static putInDom() { 
        main.removeChild(document.getElementById("fetched"))
        const div = document.getElementById("fetched") || document.createElement("div");
        div.setAttribute("id", "fetched")

        newDiv = document.getElementById("fetched")

        FetchData.Superresponse.map(obj => {
            obj
            debugger
            const subDiv = document.getElementById(obj.city) || document.createElement("div");
            subDiv.setAttribute("id", obj.city);
            subDiv.setAttribute("class", "white")
            const newH = document.getElementById("newH") || document.createElement("h2");
            newH.setAttribute("id", "newH");
            const newerH = document.getElementById("newerH") || document.createElement("h3");
            newerH.setAttribute("id", "newerH");
            const lowestH = document.getElementById("lowestH") || document.createElement("h3");
            lowestH.setAttribute("id", "lowestH");
            newerH.innerText = obj.temp_high
            lowestH.innerText = obj.temp_low;
            newH.innerText = obj.city;
            subDiv.appendChild(newH);
            subDiv.appendChild(newerH);
            subDiv.appendChild(lowestH);
            div.appendChild(subDiv);
        })

        main.appendChild(div);
    }

}



class FetchData {
    constructor() {
    }

    //Interval will be set to 14,400,000 ms in production which is 6 hours
    static fetchCityData() {
        console.log("fetching data")
        const newDiv = document.getElementById("fetched") || document.createElement("div");
        newDiv.setAttribute("id", "fetched")

        //fetch my API for city names to use for fetch to third party API 

        return fetch(BASE_URL).then(res => res.json()).then(function (json) {

            const root = document.getElementById("main");
            root.appendChild(newDiv);

            const cityArray = json.map(obj => {
                idName = {}
                idName["name"] = obj.name
                idName["id"] = obj.id
                return idName
            });
            FetchData.cityObjArray = cityArray.map(city => {

                return city = new City(city.name, city.id)

            });

            const fetchURLArray = FetchData.cityObjArray.map(cityObj => cityObj.fetchURL);
            FetchData.Superresponse = []
            return dataFromFetch = fetchURLArray.map(function (url, i) {
                let rawUrl = url.replace(/['"]+/g, '');
                let better = "http://" + rawUrl
                console.log(better)
                const response = []
                //added to track the city of the data 
                //programmatically taking city names from this app API and turing them into fetchable
                //endpoints to the third party API
                response[i] = better

                return fetch(better).then(res => res.json())
                    .then(function (json) {
                        console.log(json)
                        dataObj = {}
                        dataObj["city"] = json.name
                        dataObj["current_temp"] = json.main.temp
                        dataObj["sunset"] = json.sys.sunset
                        dataObj["temp_mid"] = json.main.temp
                        dataObj["temp_high"] = json.main.temp_max
                        dataObj["temp_low"] = json.main.temp_min
                        response["json"] = json
                        response.push(dataObj)
                        FetchData.Superresponse.push(dataObj)
                        //used to store promise data to let resolve  
                        console.log(dataObj);

                        return dataObj
                    })

            });


        });



    }
    static postData() {

        this.Superresponse.map(obj => {
            console.log(new Date().toTimeString().split(" ")[0], obj)
            FetchData.cityObjArray.map(cityObj => {


                if (cityObj.name.match(obj.city)) {
                    obj["date"] = new Date()
                    obj["fetchURL"] = cityObj.fetchURL
                    obj["city_id"] = cityObj.id
                    obj["sunset_datetime"] = new Date(obj.sunset * 1000)

                    fetchThis(obj)

                    return obj
                }
                FetchData.collectionFromData = []

                function fetchThis(obj) {
                    debugger
                    const postObjOptions = {
                        method: 'post',
                        credentials: 'same-origin',
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(obj)
                    }

                    fetch(`${POST_BASE_URL + obj.id}/temps.json`, postObjOptions)
                        .then(function (res) {
                            return res.json()
                        }).then(function (data) {

                            FetchData.fromMyDb = {}

                            FetchData.fromMyDb["date"] = data.date,
                                FetchData.fromMyDb["high_temp"] = data.temp_high,
                                FetchData.fromMyDb["low_temp"] = data.temp_low,
                                FetchData.fromMyDb["sunSet"] = new Date(data.sunset * 1000)
                            FetchData.collectionFromData.push(FetchData.fromMyDb)

                            if (FetchData.Superresponse.length == FetchData.collectionFromData.length) {
                                DOMWorker.putInDom();
                                return FetchData.fromMyDb
                            }
                        })
                }
            })


        })
    } 
   static  fetchTempDiff() {

        //fetching This Apps rails json API
        fetch(TEMP_URL).then(res => res.json()).then(function (data) {
                debugger
           
            FetchData.Superresponse = data
            DOMWorker.putInDom()
        });
    }

    

}





class City {
    constructor(name, id) {
        this.name = name
        this.id = id
        this.fetchURL = `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
    }

}


//this is an epoc converter
//new Date(obj.sunset * 1000)