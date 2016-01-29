json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :email, :age, :state, :position
  json.url contact_url(contact, format: :json)
end
