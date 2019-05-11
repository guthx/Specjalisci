class DeleteLocationIdFromSpecialist < ActiveRecord::Migration[5.2]
  def change
    remove_column :specialists, :location_id
  end
end
