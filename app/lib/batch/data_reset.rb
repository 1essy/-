class Batch::DataReset
  def self.data_reset
    # 投稿を全て削除
    Notice.where("created_at < ?", 30.days.ago).delete_all
    p "30日前の通知を全て削除しました"
  end
    #退会後３０日ユーザー削除
  #def self.customer_data_reset
    #Customer.where(is_delete: false, updated_at: 1.days.ago).delete_all
   # p "ユーザーデータ削除しました"
 # end
end