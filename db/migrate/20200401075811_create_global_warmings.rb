class CreateGlobalWarmings < ActiveRecord::Migration[6.0]
  def change
    create_table :global_warmings do |t|
      t.float :slope
      t.integer :time_elapsed
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
