class AddColoredToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :colored, :integer, default: 0
  end
end
