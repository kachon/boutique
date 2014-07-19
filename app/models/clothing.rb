class Clothing < ActiveRecord::Base
  #validates :desc, presence: true
  validates :unit_price, :presence => true, :numericality => true
  validates :date, presence: true
  validates :img_link, presence: true
end
