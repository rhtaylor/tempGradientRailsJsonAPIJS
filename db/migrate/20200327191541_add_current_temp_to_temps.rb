class AddCurrentTempToTemps < ActiveRecord::Migration[6.0]
  def change
    add_column :temps, :current_temp, :integer
  end
end
