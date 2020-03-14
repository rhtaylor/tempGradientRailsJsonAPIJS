class CreateTemps < ActiveRecord::Migration[6.0]
  def change
    create_table :temps do |t|
      t.integer :high
      t.integer :med
      t.integer :low

      t.timestamps
    end
  end
end
