const BASE_URL = "http://localhost:3000/cities.json"
const POST_BASE_URL = "http://localhost:3000"

document.addEventListener("DOMContentLoaded", function(event){ 
  getCityData()
});


function getCityData(){  
           fetch(BASE_URL).then( res => res.json() ).then(function(json){  
              CITYIDSARRAY = json.map( obj => obj.name + " " + obj.id ); 
            
             const cityArray = json.map(obj => obj.name); 
             
           
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
 
    console.log(data)
    

          }); 
        
           
        }
 
        function postFetchVals(x,y, temps){  
           
            const table = document.getElementById("main"); 
            const divy = document.createElement("div"); 
            temps.map(function(val){ 
                const hOne = document.createElement("h1");     
                hOne.innerHTML = val 
                divy.appendChild(hOne)  
                debugger
            }) 
            table.appendChild(divy)
            

            debugger
        } 
class City {
    constructor(name) {
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



function fetchPostRailsDB(obj, i){ 
    postObjOptions = {
        method: 'post', 
        credentials: 'same-origin',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
     body: JSON.stringify(obj)
    } 
    let num = CITYIDSARRAY[0].match(/\d+/)[0]  
    let post_URL = POST_BASE_URL + `/cities/${num}/temps`

fetch(post_URL, postObjOptions ).then(function(res){
 return res.json()}).then(function(data){
     debugger
 })

} 


function promiseToDom(data) {
    
    
     
}