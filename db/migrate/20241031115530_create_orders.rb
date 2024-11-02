class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string  :shop_format
      t.string  :manager_shop
      t.string  :supervisor
      t.string  :store
      t.string  :provider
      t.string  :product_group
      t.string  :required
      t.string  :product
      t.integer :day_store
      t.decimal :sales,               precision: 10, scale: 2, default: "0"
      t.decimal :remainder,           precision: 10, scale: 2, default: "0"
      t.string  :average_sales,       precision: 10, scale: 2, default: "0"
      t.string  :to_order
      t.decimal :quantum,             precision: 10, scale: 2, default: "0"
      t.integer :availability_order
      t.integer :next_order
      t.integer :cal_day_order

      t.timestamps
    end
  end
end
