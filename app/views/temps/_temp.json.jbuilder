json.extract! temp, :id, :date, :temp_high, :temp_mid, :temp_low, :city_id, :created_at, :updated_at
json.url temp_url(temp, format: :json)
