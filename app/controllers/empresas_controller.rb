class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao
  before_action :set_grid, only: [:index, :create, :edit, :update] 
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new] 
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
  before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]

  def index
    @empresas = Empresa.all
    @empresa = Empresa.new
    @empresas_grid = initialize_grid(Empresa, 
      :order => 'created_at',
      :order_direction => 'desc',
      :per_page => 10
    )
  end


  def show
  end


  def new
    @empresa = Empresa.new
  end


  def edit
  end

  def create
    @empresa = Empresa.new(empresa_params)

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to empresas_path, notice: 'Empresa criada com sucesso!' }
        format.json { render action: 'index', status: :created, location: @empresa }
      else
        format.html { render action: 'new' }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to empresas_path, notice: 'Empresa atualizada com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @empresa.destroy
    respond_to do |format|
      format.html { redirect_to empresas_url }
      format.json { head :no_content }
    end
  end

  private
    def set_grid
      @empresas_grid = initialize_grid(Empresa,
        :order => 'created_at',
        :order_direction => 'desc',
        :per_page => 10
      )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_params
      params.require(:empresa).permit(:nome, :logradouro, :rua, :numero, :bairro, :cidade, :UF, :CEP, :CNPJ, :telefone)
    end
end
