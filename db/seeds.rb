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
   name: "田中 洋介",
   email: "tanaka@yosuke",
   password: "123456",
 )

Customer.create!(
   name: "山田 翼",
   email: "yamada@tubasa",
   password: "123456",
 )

Customer.create!(
   name: "佐藤 雅弘",
   email: "satou@masahiro",
   password: "123456",
 )

Customer.create!(
   name: "原田 愛",
   email: "harada@ai",
   password: "123456",
 )

Customer.create!(
   name: "岡本 美樹",
   email: "okamoto@miki",
   password: "123456",
 )

rest = Rest.create!(
   customer_id: 1,
   describe: "緑が広がる景色を眺めて食べるお昼ごはんは最高です。",
   move_method: 0,
   smoking_area: 0,
   toilet: 2,
   address: "〒198-0212 東京都西多摩郡奥多摩町氷川１４６２",
   category: "緑",
 )
rest.image.attach(io: File.open(Rails.root.join('app/assets/images/1.jpg')), filename: 'default.jpg')

rest2 = Rest.create!(
   customer_id: 1,
   describe: "秋になると落葉が凄く綺麗で、運転に疲れた時に散歩してみるといいかも！",
   move_method: 1,
   smoking_area: 2,
   toilet: 2,
   address: "〒838-0011 福岡県朝倉市秋野鳥",
   category: "散歩",
 )
rest2.image.attach(io: File.open(Rails.root.join('app/assets/images/2.jpg')), filename: 'default.jpg')

rest3 = Rest.create!(
   customer_id: 2,
   describe: "滝の近くはマイナスイオンが出ていて、夏場でも涼しいです。駐車場がないので車の場合は近くの有料駐車場に停めていく必要があります",
   move_method: 2,
   smoking_area: 2,
   toilet: 1,
   address: "〒637-0073 奈良県五條市上野町２４６番地",
   category: "公園",
 )
rest3.image.attach(io: File.open(Rails.root.join('app/assets/images/3.jpg')), filename: 'default.jpg')

rest4 = Rest.create!(
   customer_id: 2,
   describe: "ここの海を見ていると心が落ち着きます。犬の散歩にもうってつけですよ！",
   move_method: 0,
   smoking_area: 0,
   toilet: 2,
   address: "〒516-0221 三重県度会郡南伊勢町〒",
   category: "海",
 )
rest4.image.attach(io: File.open(Rails.root.join('app/assets/images/4.jpg')), filename: 'default.jpg')

rest5 = Rest.create!(
   customer_id: 3,
   describe: "河川敷ですが一通りも少なく考え事をするのに適しています、駐車場もあるので気分転換にでも",
   move_method: 2,
   smoking_area: 1,
   toilet: 2,
   address: "〒807-0051 福岡県遠賀郡水巻町立屋敷３丁目１３",
   category: "河川敷",
 )
rest5.image.attach(io: File.open(Rails.root.join('app/assets/images/5.jpg')), filename: 'default.jpg')

rest6 = Rest.create!(
   customer_id: 3,
   describe: "とても広くて、ランニングしている人もちらほら見かけます。休憩もですが子供と遊ぶこともできると思います",
   move_method: 2,
   smoking_area: 2,
   toilet: 1,
   address: "〒470-0331 愛知県豊田市平戸橋町波岩８６−１００",
   category: "公園",
 )
rest6.image.attach(io: File.open(Rails.root.join('app/assets/images/6.jpg')), filename: 'default.jpg')

rest7 = Rest.create!(
   customer_id: 4,
   describe: "ちょっとした休憩にはちょうどいいスペースで、パン等であれば食べることも可能です",
   move_method: 0,
   smoking_area: 0,
   toilet: 1,
   address: "〒824-0031 福岡県行橋市西宮市１丁目９",
   category: "公園",
 )
rest7.image.attach(io: File.open(Rails.root.join('app/assets/images/7.jpg')), filename: 'default.jpg')

rest8 = Rest.create!(
   customer_id: 4,
   describe: "ちょっとした休憩にはちょうどいいスペースで、パン等であれば食べることも可能です、画像がないのはすいません💦",
   move_method: 0,
   smoking_area: 0,
   toilet: 1,
   address: "東京駅",
   category: "駅",
 )

rest7.image.attach(io: File.open(Rails.root.join('app/assets/images/7.jpg')), filename: 'default.jpg')

rest_comment = RestComment.create!(
   customer_id: 2,
   rest_id: 1,
   comment: "凄くきれいです。近くに行くことが多いので今度寄ってみます★",
   star: 4,
)

rest_comment2 = RestComment.create!(
   customer_id: 1,
   rest_id: 1,
   comment: "ありがとうございます！",
   star: 5,
)
