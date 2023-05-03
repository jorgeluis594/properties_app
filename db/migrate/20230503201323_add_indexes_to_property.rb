class AddIndexesToProperty < ActiveRecord::Migration[7.0]
  def change
    add_index :properties, :min_price
    add_index :properties, :max_price
    add_index :properties, :locality
    add_index :properties, :operation
  end
end
