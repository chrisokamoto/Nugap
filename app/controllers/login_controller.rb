class LoginController < ApplicationController

	before_action :valida_sessao, only: [:logout]

	def index
		redirect_to root_path, :notice => "Você está logado!" if valida_id_sessao
	end

	def login
		login = params[:login]
		senha   = params[:senha]

		return envia_mensagem_de_erro("Preencha o usuário.") if login.empty?
		return envia_mensagem_de_erro("Preencha a senha.") if senha.empty?
		
		
		if	busca_usuario_banco(login, senha)
			redirect_to home_path
		else
			return envia_mensagem_de_erro("Falha na autenticação.")
		end
	end

	def logout
		session[:id] = nil
		redirect_to login_path
	end

	private
		def busca_usuario_banco(login, senha)
			u = Usuario.find_by_login(login)
			if !u.nil?
				if u.senha == senha			
					session[:id] = u.id
					true
				else
					false
				end
			else
				false
			end
		end

		def envia_mensagem_de_erro(str)
			redirect_to login_path, :flash => {error: str}	
		end
end
