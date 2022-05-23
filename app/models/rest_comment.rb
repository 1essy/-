class RestComment < ApplicationRecord
  #バリデーション
  #validates :star, {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}, presence: true
  validates :comment, presence: true,length:{maximum:100}
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
  #アソシエーション
  belongs_to :rest
  belongs_to :customer
end
