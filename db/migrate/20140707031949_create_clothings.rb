class CreateClothings < ActiveRecord::Migration
  def change
    create_table :clothings do |t|
      t.string :desc
      t.float :unit_price

      t.timestamps
    end
  end
end
