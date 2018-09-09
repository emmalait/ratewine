# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

w1 = Winery.create name:"Charles Smith Wines", year: 2001
w2 = Winery.create name:"Barefoot", year: 1986
w3 = Winery.create name:"PrimeWine", year:2000

w1.wines.create name:"Kungfu Girl", style:"Riesling"
w1.wines.create name:"The Velvet Devil", style:"Merlot"
w1.wines.create name:"Eve", style:"Chardonnay"
w2.wines.create name:"Merlot", style:"Merlot"
w2.wines.create name:"Zinfandel", style:"Zinfandel"
w3.wines.create name:"Prohibition Zinfandel", style:"Zinfandel"
w3.wines.create name:"Prohibition Cabernet Sauvignon", style:"Cabernet Sauvignon"