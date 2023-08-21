FactoryBot.define do
  factory :shop do
    name { "Example Shop" }
    address { Faker::Address.street_address } # ランダムな住所を生成
    latitude { 12.345678 } # Google Maps Geocoding APIから習得した緯度を設定
    longitude { 23.456789 } # Google Maps Geocoding APIから習得した経度を設定
    prefecture { 1 } # 都道府県を手動で指定
    category { create(:category, name: "カテゴリー名") } # ショップとカテゴリーの関連付けを自動生成
  end

  factory :second_shop, class: 'Shop' do
    name { "Second Shop" }
    address { Faker::Address.street_address } # 別のランダムな住所を生成
    latitude { 34.567890 } # Google Maps Geocoding APIから習得した緯度を設定
    longitude { 45.678901 } # Google Maps Geocoding APIから習得した経度を設定
    prefecture { 2 } # 別の都道府県を指定
    category { create(:category, name: "カテゴリー名2") }# ショップとカテゴリーの関連付けを自動生成
  end
end

