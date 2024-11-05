class RemoveColumnStoreOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :store
  end
end
