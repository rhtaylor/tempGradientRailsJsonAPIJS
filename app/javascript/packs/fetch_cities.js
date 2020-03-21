const BASE_URL = "http://localhost:3000/cities.json"
const POST_BASE_URL = "http://localhost:3000"  
document.addEventListener("DOMContentLoaded", function (event) {
    fetchCityData() 
    document.addEventListener("click", function(e){
        e.preventDefault(); 
        e.target.matches("#green") ? addData() : console.log("eh");
        
    });
});
function addElesToDom(){
    const main = document.getElementById("main");

    const redDiv = document.createElement("div"); 
    redDiv.setAttribute("id", "red");  
    main.appendChild("red")

}
function fetchCityData(){ 
    fetch(BASE_URL).then(res => res.json()).then(function(json){
        const cityArray = json.map(obj => obj.name);
        const cityObjArray = cityArray.map( city => new City(city));
        const fetchURLArray = cityObjArray.map(cityObj => cityObj.fetchURL);
        const dataFromFetch = fetchURLArray.map(function (url, i) {
            let rawUrl = url.replace(/['"]+/g, '');
            let better = "http://" + rawUrl

            const response = {} 
            //added to trach the city of the data
            response[i] = better
            return fetch(better).then(res => res.json())
                .then(function (json) {
                    return response["json"] = json
                })
            
        });   
        updateTheDOM(dataFromFetch); 
        addData()
        debugger
    }); 
    
    
} 
const datArray = []
function addData(arg = []){
    arg.map( (obj) => datArray.push(obj))  
    console.log(datArray) 
    updateTheDOM(datArray)

}

function updateTheDOM(arg = []){ 
    const elementToAppend = document.getElementById("main");
        if (arg.length > 0){ 
            arg.map(function(cityObj){
            const table = document.createElement("table");
            const row = document.createElement("tr"); 
            const headder = document.createElement("th"); 
            headder.innerText = "City"; 
            const val = document.createElement("td");  
            debugger 
            
            headder.appendChild(val);
            elementToAppend.appendChild(headder)
            })
        } else {
    
    const newElement = document.createElement("div"); 
    const button = document.createElement("button");
    button.setAttribute("id", "green");
    
    button.innerHTML = "Show Visual Data"
    newElement.appendChild(button);
    elementToAppend.appendChild(newElement);
    debugger
        }
} 



class City{
    constructor(name){
        this.name = name 
        this.fetchURL = `api.openweathermap.org/data/2.5/weather?q=${name},us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9`
    }
}