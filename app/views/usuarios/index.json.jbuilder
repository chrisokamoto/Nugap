json.array!(@usuarios) do |usuario|
  json.extract! usuario, :login, :nome, :sobrenome, :senha, :confirmacao, :permissao
  json.url usuario_url(usuario, format: :json)
end
