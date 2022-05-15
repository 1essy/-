class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rests, dependent: :destroy
  has_many :rest_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_rests, through: :favorites, source: :rest
  has_many :view_counts, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20}
  validates :name, uniqueness: true
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

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
