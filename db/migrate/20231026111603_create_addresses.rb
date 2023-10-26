class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :post_code
      t.integer :region_id
      t.string :municipalities
      t.string :banchi
      t.string :building_name
      t.string :number
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
