class ChangeNameToBeDecimalInGlobalwarming < ActiveRecord::Migration[6.0]
  def change 
    change_column :global_warmings, :slope, :decimal
  end
end
