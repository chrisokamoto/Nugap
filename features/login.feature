# language: pt

Funcionalidade: Realizar login
	Como um usuário
	Eu quero que cada usuário possa acessar o sistema com um login

	Contexto:
		Dado que o usuário "teste" com senha "senha-teste" existe

	@screenshot @javascript @estavel
	Cenário: Login com usuário em branco
		Dado que eu estou na página para realizar o login
		Quando clico no botão "Entrar"
		Então devo estar novamente na página para realizar o login
		E devo ver "Preencha o usuário."

	@screenshot @javascript @estavel
	Cenário: Login com senha em branco
		Dado que eu estou na página para realizar o login
		Quando preencho o campo "login" com "Administrador"
		E clico no botão "Entrar"
		Então devo estar na página "login"
		E devo ver a mensagem de erro: "Preencha a senha."

	