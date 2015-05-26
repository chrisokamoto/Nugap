class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao
  before_action :set_grid, only: [:index, :create, :edit, :update]  
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
  before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]

  # GET /produtos
  # GET /produtos.json
  def index
    @produtos = Produto.all
    @produto = Produto.new
    @produtos_grid = initialize_grid(Produto, 
      :order => 'created_at',
      :order_direction => 'desc',
      :per_page => 10
    )
  end

  # GET /produtos/1
  # GET /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos
  # POST /produtos.json
  def create
    @produto = Produto.new(produto_params)

    respond_to do |format|
      if @produto.save
        format.html { redirect_to produtos_path, notice: 'Produto criado com sucesso!' }
        format.json { render action: 'index', status: :created, location: @produto }
      else
        format.html { render action: 'new' }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1
  # PATCH/PUT /produtos/1.json
  def update
    respond_to do |format|
      if @produto.update(produto_params)        
        format.html { redirect_to produtos_path, notice: 'Produto atualizado com sucesso!' }
        format.json { head :no_content }
      else        
        format.html { render action: 'index' }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.json
  def destroy
    @produto.destroy
    respond_to do |format|
      format.html { redirect_to produtos_url }
      format.json { head :no_content }
    end
  end

  private
    def set_grid
      @produtos_grid = initialize_grid(Produto,
        :order => 'created_at',
        :order_direction => 'desc',
        :per_page => 10
      )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produto_params
      params.require(:produto).permit(:tipo)
    end
end
