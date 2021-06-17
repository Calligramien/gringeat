# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"


Review.destroy_all
User.destroy_all

img_user_1 =URI.open("https://media-exp3.licdn.com/dms/image/C4D03AQEsZIoXdDUlaw/profile-displayphoto-shrink_200_200/0/1623495054751?e=1629331200&v=beta&t=lVOgMkCmzPMiH42j1b_JVtiLrCSiw25lWkabUs73wL4")
user_1 = User.create({ last_name: "Gautier", first_name: "Damien" , email: "damiengautier@gmail.com", country: Faker::Address.country, language: Faker::Nation.language, password: "123456"})
user_1.avatar.attach(io: img_user_1, filename: 'Damien.jpeg', content_type: 'image/jpeg')

10.times do
user_1 = User.create!({ last_name: Faker::Name.last_name, first_name: Faker::Name.first_name , email: Faker::Internet.email, country: Faker::Address.country, language: Faker::Nation.language, password: "123456" })
img_user_1 = URI.open("https://source.unsplash.com/collection/772333/300x300")
user_1.avatar.attach(io: img_user_1, filename: 'User.jpeg', content_type: 'image/jpeg')
end

Review.create({content:"On sent bien le cacao de cette pâte à tartiner, le gout est prononcé mais bien équilibré, j'apprécie vraiment le moment lorsque j'en tartine sur des pancakes le matin.",ratings: 4,product_code:"3017620422003",user_id: User.all[10].id})
Review.create({content:"De quoi faire chanter vos tartines ! Excellent produit qui va vous donner envie de recommencer !",ratings: 3,product_code:"3017620422003",user_id: User.all[1].id})
Review.create({content:"Le meilleur en goût et texture.",ratings:4,product_code:"3017620422003",user_id: User.all[2].id})
Review.create({content:"Délicieuse pâte à tartiner 😋.",ratings:5,product_code:"3017620422003",user_id: User.all[3].id})
Review.create({content:"Piment doux et subtilement épicé.",ratings:4,product_code:"6921804700788",user_id: User.all[4].id})
Review.create({content:"Produit de bonne qualité, et goût intéressant, légèrement fumé et très rond.",ratings:3,product_code:"6921804700788",user_id: User.all[5].id})
Review.create({content:"Hyper parfumé et subtile. Robuste, avec un piquant agréable !",ratings:3,product_code:"6921804700788",user_id: User.all[6].id})
Review.create({content:"Délicieuses gaufres au miel que je rachète régulièrement.",ratings:4,product_code:"3229820788098",user_id: User.all[7].id})
Review.create({content:"Au petit déjeuner, c'est délicieux.",ratings:3,product_code:"3229820788098",user_id: User.all[8].id})
Review.create({content:"Il y en a mais un peu plus serait pas mal !...Très bon goût, pour moi.",ratings:2,product_code:"3229820788098",user_id: User.all[9].id})



