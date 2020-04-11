# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.create([
    {name: "Phoenix", region: "southwest", fetchURL: "http://api.openweathermap.org/data/2.5/weather?q=Phoenix,us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9"
}, 
    {name: "Columbus", region: "Midwest", fetchURL:  "http://api.openweathermap.org/data/2.5/weather?q=Columbus,us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9"
},  
    {name: "Boston", region: "east", fetchURL: "http://api.openweathermap.org/data/2.5/weather?q=Boston,us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9"
}, 
    {name: "Orlando", region: "southeast",  fetchURL: "http://api.openweathermap.org/data/2.5/weather?q=Orlando,us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9"
},
    {name: "Seattle", region: "northwest", fetchURL: "http://api.openweathermap.org/data/2.5/weather?q=Seattle,us&units=imperial&APPID=fe2a775f427aa5fc92ce0379937b9ee9"
}
    
]);  



