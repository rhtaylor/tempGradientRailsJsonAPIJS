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


 GlobalWarming.create([
    {slope: -0.03, time_elapsed: 5.365, city_id:1},
    {slope: -0.00777, time_elapsed: 5.35, city_id: 2},
    {slope: 1.444, time_elapsed: 5.34, city_id:3},
    {slope: -0.999, time_elapsed: 5.345, city_id: 4}, 
    {slope: 1, time_elapsed:5.555, city_id:5} 
])


