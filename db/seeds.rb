# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.create([
    {name: "Phoenix", region: "southwest"}, 
    {name: "Columbus", region: "Midwest"},  
    {name: "Boston", region: "east"}, 
    {name: "Orlando", region: "southeast"},
    {name: "Seattle", region: "northwest"}, 
    
]);  

Temp.create([
{date:  "2020-03-22 21:40:56", temp_high: 300, temp_mid: 200, temp_low: 100, city_id: 5, sunset: 1684920275 },
{date:  "2020-03-22 21:40:56", temp_high: 200, temp_mid: 100, temp_low: 60, city_id: 3, sunset: 1984920275 },
{date:  "2020-03-22 21:40:56", temp_high: 100, temp_mid: 90, temp_low: 50, city_id: 4, sunset: 1784920275 }
]);
 


