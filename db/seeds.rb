# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.create([
    {name: "Phoenix", region: "southwest"}, 
    {name: "Las&angeles", region: "west"},  
            
    {name: "New&york", region: "east"}, 
    {name: "Orlando", region: "southeast"},
    {name: "Seattle", region: "northwest"}, 
    {name: "Las&vegas", region: "southwest"}
]); 

Temp.create([ 
    {high: 260 }, 
    {med: 200 }, 
    {high: 300}
]) 
 
DateCityTemp.create([
    { date: "03 15 2020".to_date, city_id: 1, temp_id: 1}, 
    { date: "03 19 2020".to_date, city_id: 2, temp_id: 2 } 
 ] )
