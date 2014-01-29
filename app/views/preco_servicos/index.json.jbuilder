json.array!(@preco_servicos) do |preco_servico|
  json.extract! preco_servico, :analise, :parametro, :produto, :legislacao, :preco
  json.url preco_servico_url(preco_servico, format: :json)
end
