class AddSunsetToTemps < ActiveRecord::Migration[6.0]
  def change
    add_column :temps, :sunset, :integer
  end
end
