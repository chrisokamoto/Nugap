class Usuario < ActiveRecord::Base
	before_save :criptografa_senha

	attr_accessor :senha, :confirmacao

	validates :nome, :presence => { :message => " precisa ser preenchido." }
	validates :sobrenome, :presence => { :message => " precisa ser preenchido." }
	validates :login, :presence => { :message => " precisa ser preenchido." }, :uniqueness => true
	validates :senha, :presence => { :message => " precisa ser preenchida." }  	
  	validates :permissao, :presence => { :message => " precisa ser preenchida." }  	  	
  	validate :confirmacao_e_senha_sao_iguais


  	def is_administrador?
		return self.permissao == "administrador"
	end

	def is_estagiario?
		return self.permissao == "estagiario"
	end

	def is_tecnico?
		return self.permissao == "tecnico"
	end

	def self.autenticacao(login, senha)
    usuario = find_by_login(login)
    if usuario && usuario.senha_hash == BCrypt::Engine.hash_secret(senha, usuario.senha_salt)
      usuario
    else
      nil
    end
  end
  
  def criptografa_senha
    if senha.present?
      self.senha_salt = BCrypt::Engine.generate_salt
      self.senha_hash = BCrypt::Engine.hash_secret(senha, senha_salt)
    end
  end

  	def confirmacao_e_senha_sao_iguais
		if (validates_presence_of :confirmacao,  message:  " precisa ser preenchida." )
			if (self.confirmacao != self.senha)
				errors.add(:confirmacao, " não equivale à senha digitada.")
			end
		end	
	end
end


