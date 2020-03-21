class CitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :region
end
