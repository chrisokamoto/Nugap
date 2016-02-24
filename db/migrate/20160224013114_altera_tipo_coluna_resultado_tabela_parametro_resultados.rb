class AlteraTipoColunaResultadoTabelaParametroResultados < ActiveRecord::Migration
  def change
  	change_column :parametro_resultados, :resultado, :text
  end
end
