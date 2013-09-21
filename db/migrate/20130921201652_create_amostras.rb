class CreateAmostras < ActiveRecord::Migration
  def change
    create_table :amostras do |t|
      t.date :data_fabricacao
      t.date :data_validade
      t.string :lote
      t.float :conteudo
      t.text :descricao
      t.text :caracteristicas
      t.string :solicitante
      t.string :fabricante
      t.string :produto
      t.string :embalagem
      t.string :assinatura
      t.string :unidade
      t.string :status
      t.string :certificado
      t.string :marca
      t.date :data_entrada
      t.date :data_saida
      t.string :observacoes

      t.timestamps
    end
  end
end
