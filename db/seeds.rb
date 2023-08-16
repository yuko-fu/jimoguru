# db/seeds.rb

# カテゴリーの作成
categories = Category.create([
  { name: 'レストラン' },
  { name: 'パン屋' },
  { name: 'スイーツ' }
  { name: 'その他' }
  # 他のカテゴリーも追加
])

# ショップの作成
shops = [
  {
    name: 'ステーキハウス', 
    prefecture: 1,  # プレフェクチャ (0-都道府県数-1)
    address: '東京都渋谷区...', 
    latitude: 35.12345,  # 緯度
    longitude: 139.67890,  # 経度
    category: categories[0]  # 関連するカテゴリー
  },
  {
    name: 'カフェコーナー', 
    prefecture: 2, 
    address: '大阪府大阪市...', 
    latitude: 34.56789, 
    longitude: 135.12345, 
    category: categories[1]
  }
  {
    name: 'ルタオ本店', 
    prefecture: 1, 
    address: '北海道小樽市堺町７−１６', 
    latitude: 43.191338, 
    longitude: 141.007468, 
    category: categories[0]
  }
  {
    name: 'カフェコーナー', 
    prefecture: 2, 
    address: '大阪府大阪市...', 
    latitude: 34.56789, 
    longitude: 135.12345, 
    category: categories[1]
  }
  {
    name: 'カフェコーナー', 
    prefecture: 2, 
    address: '大阪府大阪市...', 
    latitude: 34.56789, 
    longitude: 135.12345, 
    category: categories[1]
  }
  # 他のショップも追加
]

shops.each do |shop_data|
  Shop.create(shop_data)
end

# メニューの作成
menus = [
  { name: '特製ステーキセット', shop: shops[0] },
  { name: 'カフェラテ', shop: shops[1] }
  # 他のメニューも追加
]

menus.each do |menu_data|
  Menu.create(menu_data)
end

# ユーザーの作成
users = [
  {
    email: 'john@example.com', 
    password: 'password123', 
    name: 'John Doe', 
    admin: true,  # 管理者かどうか (true/false)
    prefecture: 3  # プレフェクチャ (0-都道府県数-1)
  },
  {
    email: 'jane@example.com', 
    password: 'securepass456', 
    name: 'Jane Smith', 
    admin: false, 
    prefecture: 4
  }
  # 他のユーザーも追加
]

users.each do |user_data|
  User.create(user_data)
end

# 投票の作成
votes = [
  {
    shop: shops[0], 
    user: users[0], 
    menu: menus[0], 
    content: '美味しいお肉！', 
    image: 'https://example.com/image1.jpg'  # 画像の URL
  },
  {
    shop: shops[1], 
    user: users[1], 
    menu: menus[1], 
    content: '素敵なカフェです。', 
    image: 'https://example.com/image2.jpg'  # 画像の URL
  }
  # 他の投票も追加
]

votes.each do |vote_data|
  Vote.create(vote_data)
end
