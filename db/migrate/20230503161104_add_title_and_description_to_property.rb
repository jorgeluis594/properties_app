class AddTitleAndDescriptionToProperty < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :title, :string
    add_column :properties, :description, :text
  end
end
