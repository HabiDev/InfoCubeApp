class CreateFrovs < ActiveRecord::Migration[7.0]
  def change
    create_table :frovs do |t|
      t.integer :store_id,            null: false, default: 0
      t.string  :provider
      t.string  :product_group
      t.integer :product_id
      t.string  :product
      t.integer :day_store
      t.decimal :sales_two_week,      precision: 10, scale: 2, default: "0"
      t.integer :product_ways
      t.decimal :remainder,           precision: 10, scale: 2, default: "0"
      t.string  :to_order      
      t.integer :colored,             default: 0     

      t.timestamps
    end
  end
end
