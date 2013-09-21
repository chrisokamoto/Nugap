json.array!(@statuses) do |status|
  json.extract! status, :tipo
  json.url status_url(status, format: :json)
end
