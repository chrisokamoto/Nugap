class CreateAssinaturas < ActiveRecord::Migration
  def change
    create_table :assinaturas do |t|
      t.string :nome
      t.string :tipo_conselho
      t.string :numero_conselho

      t.timestamps
    end
  end
end
