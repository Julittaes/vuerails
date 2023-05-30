class RemoveAccountFromProperties < ActiveRecord::Migration[7.0]
  def change
    remove_reference :properties, :account
  end
end
