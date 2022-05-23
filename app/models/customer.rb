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
  #通知機能
  
  has_many :active_notices, class_name: 'Notice', foreign_key: 'send_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'receive_id', dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      "no_image_user.jpg"
    end
  end

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
  
  # フォロー通知
  def create_notice_follow!(current_customer)
    temp = Notice.where(["send_id = ? and receive_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notice = current_customer.active_notices.new(
        receive_id: id,
        action: 'follow'
      )
      notice.save if notice.valid?
    end
  end

  #バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20}

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
