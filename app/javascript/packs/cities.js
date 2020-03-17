const BASE_URL = "http://localhost:3000/cities.json"

const POST_BASE_URL = "http://localhost:3000"

document.addEventListener("DOMContentLoaded", function(event){ 
  getCityData()
});


function getCityData(){  
           fetch(BASE_URL).then( res => res.json() ).then(function(json){  
            
           const CITYIDSARRAY = json.map( obj => obj.name + " " + obj.id ); 
            
           let cityArray = json.map(obj => obj.name); 

           const cityObjArray = cityArray.map( city => new City(city)); 

           const fetchArray = cityObjArray.map( cityObj => cityObj.fetchURL);  
           
            let data = fetchArray.map(function(url, i){  
                let rawUrl = url.replace(/['"]+/g, '');  
                let better = "http://" + rawUrl
                
                let response = {} 
                response[i] = better
                return fetch(better).then( res => res.json() ) 
                .then(function(json){ 
                   return response["json"] = json
                   })
        
    });   

    
    let temps = data.map(function(obj, index){ 
           
        return   index = new Temp(obj) 
        })
        
        temps.map(function(obj, i){
           
            fetch(POST_BASE_URL + `/cities/${CITYIDSARRAY[i]}/temps/new` , {
             method: 'post',
             headers: {
                 'Accept': 'application/json',
                 'Content-Type': 'application/json'
             },

             body: JSON.stringify(obj)
         });
        
        }); }
    
     

class City {
    constructor(name){
        this.name = name,  
        this.fetchURL = `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
    }  

} 
class Temp {
    constructor(obj) { 
        this.date = new Date(),
        this.high = obj.then(res => res.main.temp_max), 
        this.low = obj.then(res => res.main.temp_min) 
    }     
} 