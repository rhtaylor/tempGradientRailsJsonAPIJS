class RemoveTempFromTemps < ActiveRecord::Migration[6.0]
  def change

    remove_column :temps, :temp, :integer
  end
end
