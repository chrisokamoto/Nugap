class CreateAnalises < ActiveRecord::Migration
  def change
    create_table :analises do |t|
      t.string :tipo
      t.integer :amostra_id
      t.string :numero

      t.timestamps
    end
  end
end
