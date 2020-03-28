class AddSunsetDatetimeToTemps < ActiveRecord::Migration[6.0]
  def change
    add_column :temps, :sunset_datetime, :datetime
  end
end
