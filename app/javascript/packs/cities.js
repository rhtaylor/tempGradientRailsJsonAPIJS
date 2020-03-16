
document.addEventListener("DOMContentLoaded", function(event){
    getCityData()
})

const BASE_URL = "http://localhost:3000/cities.json" 
function getCityData(){  
    fetch(BASE_URL).then( res => res.json() ).then(function(json){
           let cityArray = json.map(obj => obj.name); 
           const cityObjArray = cityArray.map( city => new City(city));
           const fetchArray = cityObjArray.map( cityObj => cityObj.fetchURL);  
           
            let data = fetchArray.map(function(url, i){  
                let rawUrl = url.replace(/['"]+/g, '');  
                let better = "http://" + rawUrl
                console.log(better , i) 
                
                let response = {} 
                response[i] = better
                return fetch(better).then( res => res.json() ) 
                .then(function(json){ 
                   return response["json"] = json
                   
                })
           .catch(function(){
                console.log("ERROR")
            });   
           console.log(response) 
           console.log(data)
        });  
        //pass data to temp maker 
       debugger
    }) 
}
     

class City {
    constructor(name){
        this.name = name 
        this.fetchURL = `api.openweathermap.org/data/2.5/weather?q=${name},us&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
    }  

} 


class Temp {
    constructor(obj) {
        debugger
    }
} 
//code to return value of temp from fetch promise 
//fetch('http://api.openweathermap.org/data/2.5/weather?q=Las&vegas,us&APPID=fe2a775f427aa5fc92ce0379937b9ee9').then(function(res){ return res.json() }).then(function(val){ return val.main.temp }) 
// temp_max
//fetch('http://api.openweathermap.org/data/2.5/weather?q=Las&vegas,us&APPID=fe2a775f427aa5fc92ce0379937b9ee9').then(function(res){ return res.json() }).then(function(val){ return val.main.temp_max }) 
// temp_min 
//fetch('http://api.openweathermap.org/data/2.5/weather?q=Las&vegas,us&APPID=fe2a775f427aa5fc92ce0379937b9ee9').then(function(res){ return res.json() }).then(function(val){ return val.main.temp_min }) 
//sunset 
//fetch('http://api.openweathermap.org/data/2.5/weather?q=Las&vegas,us&APPID=fe2a775f427aa5fc92ce0379937b9ee9').then(function(res){ return res.json() }).then(function(val){ return val.sys.sunset })
//convert sun set and rise The Current Unix Timestamp