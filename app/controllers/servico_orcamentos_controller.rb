class ServicoOrcamentosController < ApplicationController

  before_action :set_servico_orcamento, only: [:show, :edit, :update, :destroy] 
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
  before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]
  before_action :limpa_sessao_id_amostra, only:[:show, :edit, :index, :new]  
   

  def destroy
    @servico_orcamento.destroy
    respond_to do |format|
      format.html { redirect_to edit_orcamento_path(@servico_orcamento.orcamento_id) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servico_orcamento      
      @servico_orcamento = ServicoOrcamento.find(params[:id])
    end

    

end
