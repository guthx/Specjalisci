class AddConfirmationToSpecialists < ActiveRecord::Migration[5.2]
  def change
    add_column :specialists, :confirmed, :bool
    add_column :specialists, :confirmation_code, :string
  end
end
