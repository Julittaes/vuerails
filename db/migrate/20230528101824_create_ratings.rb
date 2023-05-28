class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.references :property
      t.float :location_rating
      t.float :facilities_rating
      t.float :avg_rating

      t.timestamps
    end
  end
end
