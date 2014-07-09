class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :clothing
      t.integer :sale_id
      t.integer :unit_price

      t.timestamps
    end
  end
end
