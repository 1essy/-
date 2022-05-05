class RestComment < ApplicationRecord
  belongs_to :rest
  belongs_to :customer
end
