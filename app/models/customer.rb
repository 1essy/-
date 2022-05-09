class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rests, dependent: :destroy
  has_many :rest_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def self.guest
    find_or_create_by!(name: "guestcustomer" ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestcustomer"
    end
  end

  def active_for_authentication?
    super && (is_deleted == true)
  end
end
