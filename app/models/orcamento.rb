class Orcamento < ActiveRecord::Base

	has_many :servico_orcamentos

	accepts_nested_attributes_for :servico_orcamentos,	
								  :reject_if => Proc.new {|attributes| attributes[:qtd_amostra].blank?},
								  :allow_destroy => true

	validates_associated :servico_orcamentos

	validates :numero, :presence => { :message => " precisa ser preenchido." }
	validates :pagamento, :presence => { :message => " precisa ser selecionada." }
	validates :status, :presence => { :message => " precisa ser selecionado." }
	
end
