class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #アソシエーション
  has_many :rests, dependent: :destroy
  has_many :rest_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_rests, through: :favorites, source: :rest
  has_many :view_counts, dependent: :destroy
  
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # フォローしたときの処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  
  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  
  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end
  
  #バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20}
  validates :name, uniqueness: true
 
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  #ゲストユーザー作成機能
  def self.guest
    find_or_create_by!(name: "ゲスト" ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
    end
  end
  
  def active_for_authentication?
    super && (is_deleted == true)
  end
end
