class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :login
      t.string :nome
      t.string :sobrenome
      t.string :senha
      t.string :confirmacao
      t.string :permissao

      t.timestamps
    end
  end
end
