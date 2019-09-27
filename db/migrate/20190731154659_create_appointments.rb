class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :chore
      t.date :date
      t.string :status
      t.integer :provider_id
      t.float :cost
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
