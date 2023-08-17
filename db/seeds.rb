# seeds.rb

# Create categories
categories = Category.create([
  { name: 'レストラン' },
  { name: 'ベーカリー' },
  { name: 'スイーツ' },
  { name: 'カフェ' },
  { name: 'その他' }
])

# Create shops
shops = []
5.times do |i|
  shop = Shop.new(
    name: "Shop #{i + 1}",
    address: "Address #{i + 1}",
    category_id: categories.sample.id  # Corrected line
  )
  
  # Set latitude and longitude
  latitude = rand(35.00000..37.00000)
  longitude = rand(135.00000..137.00000)
  shop.latitude = latitude
  shop.longitude = longitude
  
  # Set prefecture
  prefecture = rand(0..46)
  shop.prefecture = prefecture
  
  shop.save
  shops << shop
end

# Create menus
menus = []
shops.each do |shop|
  5.times do |i|
    menus << shop.menus.create(
      name: "Menu #{i + 1} at #{shop.name}"
    )
  end
end

# Create users
users = []
5.times do |i|
  users << User.create(
    name: "User #{i + 1}",
    email: "user#{i + 1}@example.com",
    password: 'password',
    prefecture: rand(0..46)
  )
end

# Create votes
users.each do |user|
  5.times do |i|
    menu = menus.sample
    Vote.create(
      user: user,
      shop: menu.shop,
      menu: menu,
      content: "Vote #{i + 1} by #{user.name}"
    )
  end
end

# Create guest users
User.guest
User.guest_admin
