class AddPisToOrcamentos < ActiveRecord::Migration
  def change
  	add_column :orcamentos, :pis, :decimal, :precision => 8, :scale => 2
  end
end
