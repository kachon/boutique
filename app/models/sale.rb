class Sale < ActiveRecord::Base
  has_many :items, dependent: :destroy
  validates :date, :presence => true
  validates :payment, :presence => true
end
