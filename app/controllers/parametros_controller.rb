class ParametrosController < ApplicationController
  before_action :set_parametro, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao
  before_action :set_grid, only: [:index, :create, :edit, :update] 
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
  before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]
  before_action :limpa_sessao_id_amostra, only:[:show, :edit, :index, :new]  

  # GET /parametros
  # GET /parametros.json
  def index
    @parametros = Parametro.all
    @parametro = Parametro.new
    @parametros_grid = initialize_grid(Parametro, 
      :order => 'created_at',
      :order_direction => 'desc',
      :per_page => 10
    )
  end

  # GET /parametros/1
  # GET /parametros/1.json
  def show
  end

  # GET /parametros/new
  def new
    @parametro = Parametro.new
  end

  # GET /parametros/1/edit
  def edit
  end

  # POST /parametros
  # POST /parametros.json
  def create
    @parametro = Parametro.new(parametro_params)

    respond_to do |format|
      if @parametro.save
        format.html { redirect_to parametros_path, notice: 'Parâmetro criado com sucesso!' }
        format.json { render action: 'index', status: :created, location: @parametro }
      else
        format.html { render action: 'new' }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parametros/1
  # PATCH/PUT /parametros/1.json
  def update
    respond_to do |format|
      if @parametro.update(parametro_params)
        format.html { redirect_to parametros_path, notice: 'Parâmetro atualizado com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parametros/1
  # DELETE /parametros/1.json
  def destroy
    @parametro.destroy
    respond_to do |format|
      format.html { redirect_to parametros_url }
      format.json { head :no_content }
    end
  end

  private
    def set_grid
      @parametros_grid = initialize_grid(Parametro,
        :order => 'created_at',
        :order_direction => 'desc',
        :per_page => 10
      )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_parametro
      @parametro = Parametro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parametro_params
      params.require(:parametro).permit(:nome, :referencia, :metodo, :valor_referencia, :analise_id)
    end
end
