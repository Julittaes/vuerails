class RemovePhotoFromproperties < ActiveRecord::Migration[7.0]
  def change
    remove_column :properties, :photo, :string
  end
end
