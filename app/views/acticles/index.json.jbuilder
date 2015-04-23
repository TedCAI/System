json.array!(@acticles) do |acticle|
  json.extract! acticle, :id, :request_link
  json.url acticle_url(acticle, format: :json)
end
