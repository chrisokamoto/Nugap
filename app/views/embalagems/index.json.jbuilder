json.array!(@embalagems) do |embalagem|
  json.extract! embalagem, :tipo
  json.url embalagem_url(embalagem, format: :json)
end
