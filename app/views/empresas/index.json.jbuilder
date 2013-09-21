json.array!(@empresas) do |empresa|
  json.extract! empresa, :nome, :rua, :numero, :bairro, :cidade, :UF, :CEP, :CNPJ, :telefone
  json.url empresa_url(empresa, format: :json)
end
