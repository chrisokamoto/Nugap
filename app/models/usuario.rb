class Usuario < ActiveRecord::Base
	validates :nome, :presence => { :message => " precisa ser preenchido." }
	validates :sobrenome, :presence => { :message => " precisa ser preenchido." }
	validates :login, :presence => { :message => " precisa ser preenchido." }, :uniqueness => true
	validates :senha, :presence => { :message => " precisa ser preenchida." }
  	validates :confirmacao, :presence => { :message => " precisa ser preenchida." }
  	validates :permissao, :presence => { :message => " precisa ser preenchida." }

  	def is_administrador?
		return self.permissao == "administrador"
	end

	def is_estagiario?
		return self.permissao == "estagiario"
	end

	def is_tecnico?
		return self.permissao == "tecnico"
	end
end
