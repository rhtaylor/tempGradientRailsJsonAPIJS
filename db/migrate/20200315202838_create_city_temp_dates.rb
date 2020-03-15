class CreateCityTempDates < ActiveRecord::Migration[6.0]
  def change
    create_table :city_temp_dates do |t|
      t.datetime :date
      t.references :cities, null: false, foreign_key: true
      t.references :temps, null: false, foreign_key: true

      t.timestamps
    end
  end
end
