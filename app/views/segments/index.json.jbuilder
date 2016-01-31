json.array!(@segments) do |segment|
  json.extract! segment, :id
  json.url segment_url(segment, format: :json)
end
