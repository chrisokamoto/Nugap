json.array!(@orcamentos) do |orcamento|
  json.extract! orcamento, :numero, :data, :pagamento, :pessoa_solicitante, :empresa_solicitante, :telefone, :email, :observacao, :total_pagar, :ir, :quantidade, :prazo, :status, :desconto
  json.url orcamento_url(orcamento, format: :json)
end
