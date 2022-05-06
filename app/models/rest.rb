class Rest < ApplicationRecord
  belongs_to :customer
  has_many :rest_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image


  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  enum move_method: { "徒歩": 0, "バイク": 1, "車": 2, "大型車": 3 }
  enum smoking_area: { "わからない": 0, "可": 1, "不可": 2 }
  #enum toilet: { "わからない": 0, "有り": 1, "無し": 2 }

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end
