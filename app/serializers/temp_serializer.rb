class TempSerializer
  include FastJsonapi::ObjectSerializer
  attributes :high, :med, :low
end
