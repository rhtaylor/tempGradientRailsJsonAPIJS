class AddFetchUrlToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :fetchURL, :string
  end
end
