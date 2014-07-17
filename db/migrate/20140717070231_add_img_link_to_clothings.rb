class AddImgLinkToClothings < ActiveRecord::Migration
  def change
    add_column :clothings, :img_link, :string, :default => ""
  end
end
