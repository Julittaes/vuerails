class AddFakeLatitudeToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :fake_latitude, :float
    add_column :properties, :fake_longitude, :float
  end
end
