class Rest < ApplicationRecord
  #アソシエーション
  belongs_to :customer
  has_many :rest_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  has_many :notices, dependent: :destroy

  has_one_attached :image

  #バリデーション
  validates :describe, presence: true,length:{ minimum: 5, maximum: 84}
  validates :address, presence: true,length:{ maximum: 30}
  validates :category, presence: true,length:{ maximum: 7}

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

  # いいね通知機能
  def create_notice_favorite!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notice.where(["send_id = ? and receive_id = ? and rest_id = ? and action = ? ", current_customer.id, customer_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notice = current_customer.active_notices.new(
        rest_id: id,
        receive_id: customer_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notice.send_id == notice.receive_id
        notice.checked = true
      end
      notice.save if notice.valid? 
    end
  end

  # コメント通知機能
  def create_notice_rest_comment!(current_customer, rest_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = RestComment.select(:customer_id).where(rest_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notice_rest_comment!(current_customer, rest_comment_id, temp_id['customer_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notice_rest_comment!(current_customer, rest_comment_id, customer_id) if temp_ids.blank?
  end

  def save_notice_rest_comment!(current_customer, rest_comment_id, receive_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notice = current_customer.active_notices.new(
      rest_id: id,
      rest_comment_id: rest_comment_id,
      receive_id: receive_id,
      action: 'rest_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notice.send_id == notice.receive_id
      notice.checked = true
    end
    notice.save if notice.valid?
  end

end