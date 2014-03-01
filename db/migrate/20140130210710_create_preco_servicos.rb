class CreatePrecoServicos < ActiveRecord::Migration
  def change
    create_table :preco_servicos do |t|
      t.string :analise
      t.string :parametro
      t.string :produto      
      t.decimal :preco, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end