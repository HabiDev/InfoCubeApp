class AddForeignKeyDivision < ActiveRecord::Migration[7.0]
  def change
    remove_column :divisions, :store_id    
  end
end
