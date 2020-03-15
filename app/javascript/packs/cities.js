
document.addEventListener("DOMContentLoaded", function(event){
    getCityData()
})

const BASE_URL = "http://localhost:3000/cities.json" 
function getCityData(){  
    fetch(BASE_URL).then( res => res.json() ).then(function(json){
           let cityArray = json.map(obj => obj.name); 
           const cityObjArray = cityArray.map( city => new City(city));
           const fetchArray = cityObjArray.map( cityObj => cityObj.fetchURL);  
           debugger
            let data = fetchArray.map(function(url, i){  
                let rawUrl = url.replace(/['"]+/g, '');  
                let better = "http://" + rawUrl
                console.log(better , i) 
                debugger 
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
        data.map( dataObj => new Temp(dataObj) ) ;
        console.log(data)
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