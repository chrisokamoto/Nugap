class PrecoServicosController < ApplicationController
  before_action :set_preco_servico, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao, :valida_permissao_adm
  helper_method :formata_preco

  # GET /preco_servicos
  # GET /preco_servicos.json
  def index
    @preco_servicos = PrecoServico.all
  end

  # GET /preco_servicos/1
  # GET /preco_servicos/1.json
  def show
  end

  # GET /preco_servicos/new
  def new
    @preco_servico = PrecoServico.new
  end

  # GET /preco_servicos/1/edit
  def edit
  end

  def formata_preco
      params[:preco].to_f
      #number_to_currency(@preco_servico.preco, :precision => 0, :format => "-%u%n")
  end

  # POST /preco_servicos
  # POST /preco_servicos.json
  def create
    @preco_servico = PrecoServico.new(preco_servico_params)

    respond_to do |format|
      if @preco_servico.save
        format.html { redirect_to @preco_servico, notice: 'Preço criado com sucesso!' }
        format.json { render action: 'show', status: :created, location: @preco_servico }
      else
        format.html { render action: 'new' }
        format.json { render json: @preco_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preco_servicos/1
  # PATCH/PUT /preco_servicos/1.json
  def update
    respond_to do |format|
      if @preco_servico.update(preco_servico_params)
        format.html { redirect_to @preco_servico, notice: 'Preço atualizado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @preco_servico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preco_servicos/1
  # DELETE /preco_servicos/1.json
  def destroy
    @preco_servico.destroy
    respond_to do |format|
      format.html { redirect_to preco_servicos_url }
      format.json { head :no_content }
    end
  end

  def update_parametro
    @precos = PrecoServico.where(:analise => params[:analise], :produto => params[:produto])

    @sub_parametros = []
    existentes = [""]
    

    @precos.each do |preco|
      existentes.push( preco.parametro )
    
    end

    @sub_parametros = Parametro.where("nome NOT IN (?)", existentes)

    respond_to do |format|
      format.html
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preco_servico
      @preco_servico = PrecoServico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preco_servico_params
      params.require(:preco_servico).permit(:analise, :parametro, :produto, :legislacao, :preco)
    end
end