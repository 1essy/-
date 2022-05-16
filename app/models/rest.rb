class Rest < ApplicationRecord
  #アソシエーション
  belongs_to :customer
  has_many :rest_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :view_counts, dependent: :destroy
 

  
  has_one_attached :image

  #バリデーション
  validates :describe, presence: true,length:{maximum:100}
  validates :address, presence: true
  
  #座標変換
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  
  def self.search(search_word)
    Rest.where(['category LIKE ?', "#{search_word}"])
  end

  #画像のサイズ変更
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  enum move_method: { on_foot: 0, motorcycle: 1, car: 2, large_car: 3 }
  enum smoking_area: { smoking_area_not_sure: 0, possible: 1, impossible: 2 }
  enum toilet: { toilet_not_sure: 0, exist: 1, not_exist: 2 }

  #いいねしているかの確認
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
