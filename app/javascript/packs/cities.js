
console.log("this is hooked in")
document.addEventListener("DOMContentLoaded", function(event){
    getCityData()
})

const BASE_URL = "http://localhost:3000/cities.json" 

function getCityData(){  
    fetch(BASE_URL).then(function(res){ 
        
        return res.json() }).then(function(json){
              
            let cityArray = json.map(obj => obj.name); 
            
           const cityObjArray = cityArray.map( city => new City(city));
           const fetchArray = cityObjArray.map( cityObj => cityObj.fetchURL);  
           debugger
            let data = fetchArray.map( url => fetch(url).then(function(res){
                 console.log(res.json())
                return res.json() }) 
            .then(function(data){ 
                return data }) )
           debugger 
            } ).catch(function(){
                console.log("ERROR")
            }); 
            
    } 

class City {
    constructor(name){
        this.name = name 
        this.fetchURL = `api.openweathermap.org/data/2.5/weather?q=${name},us&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
    }  

} 


class Adaptor {
    constructor(url){
        this.url = url 
        this.data = fetch(url).then( res => res.json())
    }  

}