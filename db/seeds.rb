# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

Customer.create!(
   email: "#{n + 1}@#{n + 1}",
   name: "名#{n + 1}",
   
   introduction: "#{n + 1}です。よろしくお願いします。",
   
   password: "123456",
 )

Rest.create!(
   customer_id: n + 1,
   source: "https://#{n + 1}",
   purpose: "#{n + 1}確認のため",
   performance_review: "#{n + 1}が確認できました。",
   note:"#{n + 1}が間違ってました。",
   rate:n + 1,
   recommended_rank: 0
 )

