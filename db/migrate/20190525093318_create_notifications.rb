class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :specialist, foreign_key: true
      t.string :type
      t.boolean :seen
      t.integer :count

      t.timestamps
    end
  end
end
