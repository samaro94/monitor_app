class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.string :week_day
      t.time :hour
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
