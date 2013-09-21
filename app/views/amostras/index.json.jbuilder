json.array!(@amostras) do |amostra|
  json.extract! amostra, :data_fabricacao, :data_validade, :lote, :conteudo, :descricao, :caracteristicas, :solicitante_id, :fabricante_id, :produto_id, :embalagem_id, :assinatura_id, :unidade, :status, :certificado, :marca
  json.url amostra_url(amostra, format: :json)
end
