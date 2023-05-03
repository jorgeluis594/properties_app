class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.integer :property_type, default: 0
      t.monetize :price, null: false
      t.string :region, null: false
      t.string :locality, null: false
      t.integer :bedrooms
      t.decimal :bathrooms, precision: 4, scale: 2
      t.decimal :area, precision: 7, scale: 2

      t.timestamps
    end
  end
end
