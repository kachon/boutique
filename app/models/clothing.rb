class Clothing < ActiveRecord::Base
  validates :desc, presence: true
  validates :unit_price, presence: true
end
