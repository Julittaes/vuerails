class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :account
      t.string :title
      t.integer :price
      t.integer :rooms
      t.integer :bathrooms
      t.string :photo
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
