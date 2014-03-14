class Amostra < ActiveRecord::Base

	after_save    :expire_amostra_all_cache
	after_destroy :expire_amostra_all_cache
	
	has_many :parametro_resultados


	accepts_nested_attributes_for :parametro_resultados,
								  :reject_if => Proc.new {|attributes| attributes[:resultado].blank?},
								  :allow_destroy => true

	validates_associated :parametro_resultados

	validates :produto, :presence => { :message => " precisa ser preenchido." }
	validates :assinatura, :presence => { :message => " precisa ser preenchida." }
	validates :solicitante, :presence => { :message => " precisa ser preenchido." }
	validates :fabricante, :presence => { :message => " precisa ser preenchida." }	

	def self.all_cached
  		Rails.cache.fetch('Amostra.all') { all }
	end

	def expire_amostra_all_cache
  		Rails.cache.delete('Amostra.all')
	end

end
