class Amostra < ActiveRecord::Base
	
	has_many :parametro_resultados	


	accepts_nested_attributes_for :parametro_resultados,
								  :reject_if => Proc.new {|attributes| attributes[:resultado].blank?},
								  :allow_destroy => true

	validates_associated :parametro_resultados

	validates :produto, :presence => { :message => " precisa ser preenchido." }
	validates :assinatura, :presence => { :message => " precisa ser preenchida." }
	validates :solicitante, :presence => { :message => " precisa ser preenchido." }
	validates :fabricante, :presence => { :message => " precisa ser preenchida." }
end