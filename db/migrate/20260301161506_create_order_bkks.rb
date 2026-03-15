class CreateOrderBkks < ActiveRecord::Migration[7.0]
  def change
    create_table :order_bkks do |t|
      t.text :store_manager
      t.integer :store_id,              null: false, default: 0
      t.string  :product_category
      t.string  :product_group
      t.integer :product_id
      t.string  :product
      t.integer :sales_four_weeks_ago
      t.integer :sales_three_weeks_ago
      t.integer :sales_two_weeks_ago
      t.integer :sales_one_weeks_ago
      t.integer :average_sales  
      t.integer :recommended_order
      t.integer :remainder
      t.integer :order  
      t.integer :additional_order  
      t.integer :colored,               default: 0   

      t.timestamps
    end
  end
end