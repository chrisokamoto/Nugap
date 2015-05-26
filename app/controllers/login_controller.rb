class LoginController < ApplicationController

	before_action :valida_sessao, only: [:logout]
	before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
	before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
	before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]

	def index
		redirect_to root_path, :notice => "Você está logado!" if valida_id_sessao
	end

	def login
		login = params[:login]
		senha   = params[:senha]

		return envia_mensagem_de_erro("Preencha o usuário.") if login.empty?
		return envia_mensagem_de_erro("Preencha a senha.") if senha.empty?

		usuario = Usuario.autenticacao(params[:login], params[:senha])

		if usuario
		    session[:id] = usuario.id
    		redirect_to amostras_path
  		else
    		return envia_mensagem_de_erro("Falha na autenticação.")
  		end

	end

	def logout
		session[:id] = nil
		redirect_to login_path
	end

	private		

		def envia_mensagem_de_erro(str)
			redirect_to login_path, :flash => {error: str}	
		end
end
