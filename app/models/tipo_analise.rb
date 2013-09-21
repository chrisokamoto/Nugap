class TipoAnalise < ActiveRecord::Base

	validates :tipo, :presence => { :message => " precisa ser preenchido." }, :uniqueness => { :message => " já existe no banco." }
end
