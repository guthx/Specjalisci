class ChangeConfirmedInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :specialists, :confirmed, :boolean, :default => false
  end
end
