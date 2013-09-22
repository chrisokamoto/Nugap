class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :login
      t.string :nome
      t.string :sobrenome
      t.string :senha_hash
      t.string :senha_salt
      t.string :permissao

      t.timestamps
    end
  end
end
