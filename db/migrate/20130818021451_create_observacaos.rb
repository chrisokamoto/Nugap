class CreateObservacaos < ActiveRecord::Migration
  def change
    create_table :observacaos do |t|
      t.string :texto
      t.integer :amostra_id

      t.timestamps
    end
  end
end
