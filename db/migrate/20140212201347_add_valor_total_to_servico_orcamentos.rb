class AddValorTotalToServicoOrcamentos < ActiveRecord::Migration
  def change
  	add_column :servico_orcamentos, :valor_total, :decimal, :precision => 8, :scale => 2
  end
end
