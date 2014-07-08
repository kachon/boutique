class AddDateToClothings < ActiveRecord::Migration
  def change
    add_column :clothings, :date, :date
  end
end
