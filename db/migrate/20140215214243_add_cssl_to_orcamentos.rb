class AddCsslToOrcamentos < ActiveRecord::Migration
  def change
  	add_column :orcamentos, :cssl, :decimal, :precision => 8, :scale => 2
  end
end
