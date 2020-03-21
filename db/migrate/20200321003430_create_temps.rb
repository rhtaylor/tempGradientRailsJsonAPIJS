class CreateTemps < ActiveRecord::Migration[6.0]
  def change
    create_table :temps do |t|
      t.datetime :date
      t.integer :temp_high
      t.integer :temp_mid
      t.integer :temp_low
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
