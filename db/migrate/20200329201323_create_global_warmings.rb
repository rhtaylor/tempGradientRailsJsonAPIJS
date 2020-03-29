class CreateGlobalWarmings < ActiveRecord::Migration[6.0]
  def change
    create_table :global_warmings do |t|
      t.string :city
      t.integer :time_change
      t.integer :slope
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
