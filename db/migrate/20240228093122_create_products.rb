class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :store_section, null: false, foreign_key: true
      t.string :name, null: false, limit: 128
      t.string :store_name,  limit: 64
      t.boolean :purchased, null: false, default: false
      t.date :purchase_date, null: false
      t.integer :quantity, null: false
      t.check_constraint 'quantity >= 0', name: 'quantity_positive_constraint'
      t.timestamps
    end
  end
end
