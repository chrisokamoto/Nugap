class ChangeColunaNumeroTabelaEmpresas < ActiveRecord::Migration

  def self.up
  	change_column :empresas, :numero, :string
  end

  def self.down
   change_column :empresas, :numero, :integer
  end 
end
