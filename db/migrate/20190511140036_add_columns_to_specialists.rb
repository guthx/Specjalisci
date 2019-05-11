class AddColumnsToSpecialists < ActiveRecord::Migration[5.2]
  def change
    add_column :specialists, :email, :string
    add_column :specialists, :phone, :string
    add_column :specialists, :additional_info, :string
  end
end
