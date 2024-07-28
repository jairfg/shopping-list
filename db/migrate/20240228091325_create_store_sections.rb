class CreateStoreSections < ActiveRecord::Migration[7.1]
  def change
    create_table :store_sections do |t|
      t.string :name, limit: 64, null: false
      t.timestamps
    end
  end
end
