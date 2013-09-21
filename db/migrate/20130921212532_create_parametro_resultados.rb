class CreateParametroResultados < ActiveRecord::Migration
  def change
    create_table :parametro_resultados do |t|
      t.string :parametro
      t.string :resultado
      t.string :tipo
      t.integer :amostra_id
      t.string :conclusao

      t.timestamps
    end
  end
end
