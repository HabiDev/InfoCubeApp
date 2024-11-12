class CreateAssortments < ActiveRecord::Migration[7.0]
  def change
    create_table :assortments do |t|
      t.integer :store_id,            null: false, default: 0           
      t.string  :provider
      t.string  :product_group
      t.string  :product
      t.integer :product_id
      t.string  :comment
      t.decimal :remainder,           precision: 10, scale: 2, default: "0"
      t.decimal :sales,               precision: 10, scale: 2, default: "0"

      t.timestamps
    end
  end
end
