class CreateParametros < ActiveRecord::Migration
  def change
    create_table :parametros do |t|
      t.string :nome
      t.string :referencia
      t.string :metodo
      t.string :valor_referencia

      t.timestamps
    end
  end
end
