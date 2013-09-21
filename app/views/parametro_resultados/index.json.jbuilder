json.array!(@parametro_resultados) do |parametro_resultado|
  json.extract! parametro_resultado, :parametro_id, :resultado, :analise_id
  json.url parametro_resultado_url(parametro_resultado, format: :json)
end
