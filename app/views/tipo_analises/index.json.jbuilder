json.array!(@tipo_analises) do |tipo_analise|
  json.extract! tipo_analise, :tipo
  json.url tipo_analise_url(tipo_analise, format: :json)
end
