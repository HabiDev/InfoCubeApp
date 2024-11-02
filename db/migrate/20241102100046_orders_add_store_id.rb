class OrdersAddStoreId < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :shop_format
    remove_column :orders, :manager_shop
    remove_column :orders, :supervisor
    add_column    :orders, :store_id, :integer, null: false, default: 0
  end
end
