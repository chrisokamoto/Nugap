class AddCofinsToOrcamentos < ActiveRecord::Migration
  def change
  	add_column :orcamentos, :cofins, :decimal, :precision => 8, :scale => 2
  end
end
