class Embalagem < ActiveRecord::Base
	belongs_to :amostra
	
	validates :tipo, :presence => { :message => " precisa ser preenchido." }, :uniqueness => { :message => " já existe no banco." }
end