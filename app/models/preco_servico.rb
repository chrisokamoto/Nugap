class PrecoServico < ActiveRecord::Base

	validates :analise, :presence => { :message => " precisa ser preenchida." }
	validates :parametro, :presence => { :message => " precisa ser preenchido." }
	validates :produto, :presence => { :message => " precisa ser preenchido." }
	validates :preco, :presence => { :message => " precisa ser preenchido." }

end
