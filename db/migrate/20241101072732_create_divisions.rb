class CreateDivisions < ActiveRecord::Migration[7.0]
  def change
    create_table :divisions do |t|
      t.string  :name,            null: false 
      t.integer :store_id,        null: false,    foreign_key: true
      t.string  :organization
      t.timestamps
    end
  end
end
