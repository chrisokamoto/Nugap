class CreateServicoOrcamentos < ActiveRecord::Migration
  def change
    create_table :servico_orcamentos do |t|
      t.string :produto
      t.string :analise
      t.string :parametro
      t.integer :qtd_amostra
      t.decimal :valor_unitario, :precision => 8, :scale => 2 
      t.decimal :valor_total, :precision => 8, :scale => 2
      t.integer :orcamento_id

      t.timestamps
    end
  end
end
