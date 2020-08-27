class CreateTools < ActiveRecord::Migration[6.0]
  def change
    create_table :tools do |t|
      t.string :name
      t.integer :quantity
      t.integer :user_id
    end
  end
end