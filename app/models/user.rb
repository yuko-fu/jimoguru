class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, uniqueness: { case_sensitive: false }, 
                                   length: { maximum: 30 }  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :votes, dependent: :destroy
  has_many :shops, through: :votes
  enum prefecture:[
  :北海道,:青森県,:岩手県,:宮城県,:秋田県,:山形県,:福島県,
  :茨城県,:栃木県,:群馬県,:埼玉県,:千葉県,:東京都,:神奈川県,
  :新潟県,:富山県,:石川県,:福井県,:山梨県,:長野県,
  :岐阜県,:静岡県,:愛知県,:三重県,
  :滋賀県,:京都府,:大阪府,:兵庫県,:奈良県,:和歌山県,
  :鳥取県,:島根県,:岡山県,:広島県,:山口県,
  :徳島県,:香川県,:愛媛県,:高知県,
  :福岡県,:佐賀県,:長崎県,:熊本県,:大分県,:宮崎県,:鹿児島県,
  :沖縄県
  ]
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end
  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト管理者ユーザー"
      user.admin = true
    end
  end
  def guest?
    !is_valid
    # role == "ゲストユーザー"
  end
  
  def valid_for_authentication?
    super && !is_valid
  end
end
