json.array!(@parametros) do |parametro|
  json.extract! parametro, :nome, :referencia, :metodo, :valor_maximo, :valor_minimo, :analise_id
  json.url parametro_url(parametro, format: :json)
end
