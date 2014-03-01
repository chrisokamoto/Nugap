class Empresa < ActiveRecord::Base
	belongs_to :amostra

	validates :nome, :presence => { :message => " precisa ser preenchido." }, :uniqueness => { :message => " já existe no banco." }	

	
end