json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :email, :date_of_birth, :state, :position
  json.url contact_url(contact, format: :json)
end
