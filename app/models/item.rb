class Item < ActiveRecord::Base
  belongs_to :sale
  validates :sale_id, :presence => true
  validates :unit_price, :presence => true, :numericality => true

  def clothing_desc
    clothing = Clothing.find_by_id(self.clothing)
    if clothing
      return clothing.desc
    else
      return nil
    end
  end
end
