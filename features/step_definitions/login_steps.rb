Dado(/^que o usuário "(.*?)" com senha "(.*?)" existe$/) do |nome, senha|
  Usuario.create(nome: nome, senha: senha)
end

Então(/^devo estar na página de escolher o local$/) do
	expect(current_path).to eql(path_to("login"))
end

Dado(/^que eu estou na página para realizar o login$/) do
  steps %{
  	Dado que eu estou em "login"
  }
end

Então(/^devo estar novamente na página para realizar o login$/) do
  steps %{
  	Então devo estar na página "login"
  }
end



