class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nome
      t.string :logradouro
      t.string :rua
      t.integer :numero
      t.string :bairro
      t.string :cidade
      t.string :UF
      t.string :CEP
      t.string :CNPJ
      t.string :telefone

      t.timestamps
    end
  end
end
