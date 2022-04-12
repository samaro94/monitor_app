class CreateServiceBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :service_blocks do |t|
      t.string :week_day
      t.datetime :from
      t.datetime :to
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
