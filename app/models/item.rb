class Item < ActiveRecord::Base
  belongs_to :sale
  validates :sale_id, :presence => true
end
