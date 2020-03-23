const BASE_URL = "http://localhost:3000/cities.json"
const POST_BASE_URL = "http://localhost:3000/cities/"  
const TEMP_URL = "http://localhost:3000/cities/temps/diff.json"
document.addEventListener("DOMContentLoaded", function (event){
        FetchData.fetchCityData();
        //timeIntervalcallback();
    document.addEventListener("click", function(e){
        e.preventDefault() 
        e.target.matches("#green") ? FetchData.postData() : console.log("Not Here"); 
        e.target.matches("#button2") ? DiffInTemp.fetchTempDiff() : console.log("Try again");
    });  
}); 

// function timeIntervalcallback(){
//     setInterval(() => {
//         FetchData.fetchCityData()
//     }, 90000000);
// }

class FetchData {
    constructor(){

    } 

    //Interval will be set to 14,400,000 ms in production which is 6 hours
 static fetchCityData(){   

    const newDiv = document.createElement("div"); 
    newDiv.setAttribute("id", "fetched")
    const waiting = document.createElement("h2");  
    waiting.setAttribute("id", "waiting")
    waiting.innerText = "Fetching Weather Data" 
    newDiv.appendChild(waiting);
    //fetch my API for city names to use for fetch to third party API 

   return  fetch(BASE_URL).then(res => res.json()).then(function (json) { 
        
            const root = document.getElementById("main"); 
            root.appendChild(newDiv);
        
        const cityArray = json.map(obj => { 
          idName = {} 
         idName["name"] = obj.name
         idName["id"]  = obj.id  
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
static postData(){ 
       
    this.Superresponse.map(obj =>{   
        console.log(new Date().toTimeString().split(" ")[0] , obj)
         FetchData.cityObjArray.map( cityObj => {  
             
            
             if (cityObj.name.match(obj.city)){  
                obj["date"] = new Date()
                obj["fetchURL"] = cityObj.fetchURL
                obj["city_id"] = cityObj.id 
                fetchThis(obj)
                return obj
            } 
            FetchData.collectionFromData = [] 

            function fetchThis(obj){  
                
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
                    
                    if (FetchData.Superresponse.length == FetchData.collectionFromData.length){ 
                                putInDom();    
                            return FetchData.fromMyDb 
                               }
                } ) 
        } 
}) 


}) 
}
} 

class City {
    constructor(name, id){ 
        this.name = name
        this.id = id 
        this.fetchURL = `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
    }

}  

root = document.getElementById("main");
const button = document.createElement("button");
button.setAttribute("id", "green"); 
button.setAttribute("class", "button")
button.innerText = "Display Current Temps"
root.appendChild(button)
function postToDatabase(){  

    //save data to rails db with POST fetch()  
    FetchData.postData();   
    let pulledData = FetchData.fromMyDb 
} 
    

    //use data from current GET fetch() 
function putInDom(){  
        const div = document.getElementById("greenfire") || document.createElement("div"); 
        div.setAttribute("id", "greenfire") 
        newDiv = document.getElementById("fetched") 
        
        waiting = document.getElementById("waiting") 
        waiting.remove()
    FetchData.Superresponse.map(obj => { obj 
          
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
    } ) 
   
    newDiv.appendChild(div);
    }

class Temp {
    constructor(obj) {
            this.date = new Date(),
            this.high = obj.then(res => res.main.temp_max),
            this.low = obj.then(res => res.main.temp_min)
    }
}  

const button2 = document.createElement("button");
button2.innerText = "Display Temps Diff";
button2.setAttribute("id", "button2"); 
button2.setAttribute("class", "button")
root.appendChild(button2); 



class DiffInTemp {
    constructor(){

    } 

static fetchTempDiff(){
    fetch(TEMP_URL).then(res => res.json()).then(function(data){ 
        
        keys = Object.keys(data) 
        useableData = keys.map( key => data[key] )
        debugger
        FetchData.Superresponse = useableData
        putInDom()   
    });
}

}