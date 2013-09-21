class ParametroResultadosController < ApplicationController
  before_action :set_parametro_resultado, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao_nao_permitida

  # GET /parametro_resultados
  # GET /parametro_resultados.json
  def index
    @parametro_resultados = ParametroResultado.all
  end

  # GET /parametro_resultados/1
  # GET /parametro_resultados/1.json
  def show
  end

  # GET /parametro_resultados/new
  def new
    @amostra = Amostra.find(params[:amostra_id])    
    @parametro_resultado = ParametroResultado.new
    @parametro_resultado.amostra_id = @amostra.id
  end

  # GET /parametro_resultados/1/edit
  def edit
  end

  # POST /parametro_resultados
  # POST /parametro_resultados.json
  def create
    @parametro_resultado = ParametroResultado.new(parametro_resultado_params)

    respond_to do |format|
      if @parametro_resultado.save
        format.html { redirect_to @parametro_resultado, notice: 'Resultado criado com sucesso!' }
        format.json { render action: 'show', status: :created, location: @parametro_resultado }
      else
        format.html { render action: 'new' }
        format.json { render json: @parametro_resultado.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parametro_resultados/1
  # PATCH/PUT /parametro_resultados/1.json
  def update
    respond_to do |format|
      if @parametro_resultado.update(parametro_resultado_params)
        format.html { redirect_to @parametro_resultado, notice: 'Resultado atualizado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parametro_resultado.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parametro_resultados/1
  # DELETE /parametro_resultados/1.json
  def destroy
    @parametro_resultado.destroy
    respond_to do |format|
      format.html { redirect_to parametro_resultados_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parametro_resultado
      @parametro_resultado = ParametroResultado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    private
    def parametro_resultado_params
      params.require(:parametro_resultado).permit(:parametro, :resultado, :amostra_id, :tipo, :conclusao)
    end
end
