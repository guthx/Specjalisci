class AddUserToSpecialist < ActiveRecord::Migration[5.2]
  def change
    add_reference :specialists, :user, foreign_key: true
  end
end
