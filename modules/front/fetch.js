class FetchData {
    constructor() {
    }

    //Interval will be set to 14,400,000 ms in production which is 6 hours
    static fetchCityData() {
       
        const newDiv = document.getElementById("fetched") || document.createElement("div");
        newDiv.setAttribute("id", "fetched")

        //fetch this apps API for city names or fetchURLs to use for fetch to third party API 

        return fetch(BASE_URL).then(res => res.json()).then(function (json) {

            const root = document.getElementById("main");
            root.appendChild(newDiv);

            const cityArray = json.map(obj => {

                const idName = {}
                idName["name"] = obj.name
                idName["id"] = obj.id

                return idName
            });
            FetchData.cityObjArray = cityArray.map(city => {
                
                return city = new City(city.id, null, city.name)


            });
            let dataFromFetch;
            const fetchURLArray = FetchData.cityObjArray.map(cityObj => cityObj.fetchURL);

            FetchData.Superresponse = [] 
            
            return dataFromFetch = fetchURLArray.map(function (url, i) {
                
                let rawUrl = url.replace(/['"]+/g, '');
                let better = "http://" + rawUrl

               
                const response = []
                //added to track the city of the data 
                //programmatically taking city names from this app API and turing them into fetchable
                //endpoints to the third party API
                response[i] = better

                return fetch(better).then(res => res.json())

                    .then(function (json) {
                         //west coast is maybe lon -119 to lon -110 above -100(texas) and is east coast -100 to -70
                       
                        const dataObj = {}
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
                       

                        return dataObj
                    })

            });


        });



    }
    static count = 0
    static counter() {

        this.count++;
        let counter = document.getElementById("counter") || document.createElement("p");
        counter.setAttribute("id", "counter")
        counter.innerText = this.count
        let main = document.getElementById("main");
        main.appendChild(counter);
    }
    static postData() {

        FetchData.Superresponse.map(obj => {

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
    static fetchTempDiff() {

        //fetching This Apps rails json API
        fetch(TEMP_URL).then(res => res.json()).then(function (data) {
             
            
            DOMWorker.putInDomminos(data)
        });
    }


    static timeIntervalCallback() {

        if (pause.innerText == "pause ||") {
            pause.innerText = "start >>";
            clearInterval(this.interval)

        } else {
            pause.innerText = "pause ||"
            //interval will be set to about 12 hours in production 
            //or 43,200,000 ms 3600000 == 4 hours
            this.interval = setInterval(callFunctions, 60000)
            function callFunctions() {
                FetchData.fetchCityData();
                setTimeout(FetchData.postData, 2000);
                FetchData.counter()
            }
        }


    }

    static searchForCity() {
        const input = document.getElementById("input");
        let city = input.value
        let sanitizedCity = city.replace(/=/, "")

        let x = sanitizedCity.match(/^[a-z]/) || sanitizedCity
        let noCaseIssues = sanitizedCity.replace(/^[a-z]/, x[0].toUpperCase())
        let inputCheck = noCaseIssues.replace(/\s+/, "&")

        

        let fetchURL = `http://api.openweathermap.org/data/2.5/weather?q=${inputCheck},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`

        fetch(fetchURL).then(res => { 

            if (res.status === 200) {
             
                let url = res.url 
                 
                let city = FetchData.cityFactory(res);
                FetchData.addCityToMyDB( city )
                return res.json()
            } else if (res.status === 404) {
                alert("City Not Found! Check spelling or try a different city.")
            }
        })

            .catch(function (response) {
                alert("Try later: Could not connect")
            })
        
   


    } 
    static cityFactory(res){ 
        let url = res.url
        let id = null 
        let name = null
        let newCity; 
        
        newCity = (new City(id, url, name) )
        return newCity
    }
    static addCityToMyDB(arg) {


        let obj = { fetchURL: arg.fetchURL }

        let postObjOptions = {
            method: 'post',
            credentials: 'same-origin',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(obj)
        }

        fetch(NEW_CITY_URL, postObjOptions)
            .then(function (res) {
                return res.json()
            }).then(function (data) {

                const success = document.createElement("div")
                success.setAttribute("id", "success");

                const p = document.createElement("p");
                p.innerText = "Your city is now being tracked by Boiling Forest!"
                success.appendChild(p)
                main.appendChild(success)
                FetchData.fetchCityData();
                setTimeout(function () {
                    main.removeChild(success)

                    main.removeChild(cityForm)
                    FetchData.postData()
                }, 3000);
            })
    }




}
