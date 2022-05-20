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
  
  def get_rest_image
    if image.attached?
      image
    else
      "no_image.jpg"
    end
  end



  enum move_method: { on_foot: 0, motorcycle: 1, car: 2, large_car: 3 }
  enum smoking_area: { smoking_area_not_sure: 0, possible: 1, impossible: 2 }
  enum toilet: { toilet_not_sure: 0, exist: 1, not_exist: 2 }

  #いいねしているかの確認
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
