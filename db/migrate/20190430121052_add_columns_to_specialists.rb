class AddColumnsToSpecialists < ActiveRecord::Migration[5.2]
  def change
    add_column :specialists, :city, :string
    add_column :specialists, :street, :string
    add_column :specialists, :coordx, :string
    add_column :specialists, :coordy, :string
  end
end
