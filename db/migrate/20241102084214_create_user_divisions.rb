class CreateUserDivisions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_divisions do |t|
      t.references :user,             null: false, foreign_key: true
      t.references :division,         null: false, foreign_key: true, default: 0
      t.timestamps
    end
  end
end
