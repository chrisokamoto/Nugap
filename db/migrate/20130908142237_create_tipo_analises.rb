class CreateTipoAnalises < ActiveRecord::Migration
  def change
    create_table :tipo_analises do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
