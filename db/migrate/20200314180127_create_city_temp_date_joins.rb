class CreateCityTempDateJoins < ActiveRecord::Migration[6.0]
  def change
    create_table :city_temp_date_joins do |t|
      t.datetime :day
      t.references :city, null: false, foreign_key: true
      t.references :temp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
