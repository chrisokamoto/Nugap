json.array!(@produtos) do |produto|
  json.extract! produto, :nome
  json.url produto_url(produto, format: :json)
end
