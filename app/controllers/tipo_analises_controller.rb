class TipoAnalisesController < ApplicationController
  before_action :set_tipo_analise, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao
  before_action :set_grid, only: [:index, :create, :edit, :update] 
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
  before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]
  before_action :limpa_sessao_id_amostra, only:[:show, :edit, :index, :new]  

  # GET /tipo_analises
  # GET /tipo_analises.json
  def index
    @tipo_analises = TipoAnalise.all
    @tipo_analise = TipoAnalise.new
    @analises_grid = initialize_grid(TipoAnalise, 
      :order => 'created_at',
      :order_direction => 'desc',
      :per_page => 10
    )
  end

  # GET /tipo_analises/1
  # GET /tipo_analises/1.json
  def show
  end

  # GET /tipo_analises/new
  def new
    @tipo_analise = TipoAnalise.new
  end

  # GET /tipo_analises/1/edit
  def edit
  end

  # POST /tipo_analises
  # POST /tipo_analises.json
  def create
    @tipo_analise = TipoAnalise.new(tipo_analise_params)

    respond_to do |format|
      if @tipo_analise.save
        format.html { redirect_to tipo_analises_path, notice: 'Análise criada com sucesso!' }
        format.json { render action: 'index', status: :created, location: @tipo_analise }
      else
        format.html { render action: 'new' }
        format.json { render json: @tipo_analise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_analises/1
  # PATCH/PUT /tipo_analises/1.json
  def update
    respond_to do |format|
      if @tipo_analise.update(tipo_analise_params)
        format.html { redirect_to tipo_analises_path, notice: 'Análise atualizada com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @tipo_analise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_analises/1
  # DELETE /tipo_analises/1.json
  def destroy
    @tipo_analise.destroy
    respond_to do |format|
      format.html { redirect_to tipo_analises_url }
      format.json { head :no_content }
    end
  end

  private
    def set_grid
      @analises_grid = initialize_grid(TipoAnalise,
        :order => 'created_at',
        :order_direction => 'desc',
        :per_page => 10
      )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_analise
      @tipo_analise = TipoAnalise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_analise_params
      params.require(:tipo_analise).permit(:tipo)
    end
end
