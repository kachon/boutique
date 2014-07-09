class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.date :date
      t.string :remark
      t.string :payment

      t.timestamps
    end
  end
end
