class AddRatingToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :rating, :float
  end
end
