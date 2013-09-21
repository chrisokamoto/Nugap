class Parametro < ActiveRecord::Base

	validates :nome, :presence => true, :uniqueness => true
	validates :referencia, :presence => true
	validates :metodo, :presence => true
end