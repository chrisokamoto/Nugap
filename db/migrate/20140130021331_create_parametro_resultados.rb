class CreateParametroResultados < ActiveRecord::Migration
  def change
    create_table :parametro_resultados do |t|
      t.string :parametro
      t.string :resultado
      t.string :tipo
      t.integer :amostra_id
      t.string :conclusao
      t.string :referencia_parametro
      t.string :metodo_parametro
      t.string :valor_referencia_parametro

      t.timestamps
    end
  end
end