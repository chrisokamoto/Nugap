class CreateResultados < ActiveRecord::Migration
  def change
    create_table :resultados do |t|
      t.string :valor
      t.integer :parametro_id
      t.string :amostra_id

      t.timestamps
    end
  end
end
