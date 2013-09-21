class CreateUnidades < ActiveRecord::Migration
  def change
    create_table :unidades do |t|
      t.string :tipo
      t.integer :amostra_id

      t.timestamps
    end
  end
end
