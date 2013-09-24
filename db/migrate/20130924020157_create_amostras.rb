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
      t.string :fabricante_rua
      t.integer :fabricante_numero
      t.string :fabricante_bairro
      t.string :fabricante_cidade
      t.string :fabricante_UF
      t.string :fabricante_CEP
      t.string :fabricante_CNPJ
      t.string :fabricante_telefone
      t.string :solicitante_rua
      t.integer :solicitante_numero
      t.string :solicitante_bairro
      t.string :solicitante_cidade
      t.string :solicitante_UF
      t.string :solicitante_CEP
      t.string :solicitante_CNPJ
      t.string :solicitante_telefone
      t.string :assinatura_tipo_conselho
      t.string :assinatura_numero_conselho

      t.timestamps
    end
  end
end
