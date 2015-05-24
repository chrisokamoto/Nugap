class PrecoServicosController < ApplicationController
  before_action :set_preco_servico, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao, :valida_permissao_adm
  before_action :get_parametros_preco, only: [:index, :edit]
  before_action :set_grid, only: [:index, :create, :edit, :update]    
  helper_method :formata_preco, :get_parametros_preco

  # GET /preco_servicos
  # GET /preco_servicos.json
  def index
    puts "?????????????????????"
    puts $is_from_limpa_sessao
    if($is_from_limpa_sessao)
      session[:preco_params] = nil 
    end
    $is_from_limpa_sessao = false
    @preco_servicos = PrecoServico.all
    @preco_servico = PrecoServico.new(session[:preco_params])
    puts "22222222222222222222"
  end

  # GET /preco_servicos/1
  # GET /preco_servicos/1.json
  def show
  end

  # GET /preco_servicos/new
  def new
    @preco_servico = PrecoServico.new    

    get_parametros_preco
  end

  # GET /preco_servicos/1/edit
  def edit
    get_parametros_preco
  end

  def formata_preco
      params[:preco].to_f      
  end

  def limpa_sessao
    puts "!!!!!!!!!!!!LIMPA"
    $is_from_limpa_sessao = true 
    respond_to do |format|
      format.html { redirect_to preco_servicos_path, status: :ok}   
      format.json { render json: $is_from_limpa_sessao }           
    end
  end

  # POST /preco_servicos
  # POST /preco_servicos.json
  def create
    @preco_servico = PrecoServico.new(preco_servico_params)            
    session[:preco_params] = preco_servico_params
    session[:preco_params][:produto] = ""

    respond_to do |format|
      if @preco_servico.save        
        get_parametros_preco
        format.html { redirect_to preco_servicos_path, :id => "" }     
        format.json { render action: 'index', status: :created, location: @preco_servico }
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
          session[:preco_params] = nil
          format.html { redirect_to preco_servicos_path, flash: {success: 'Preço criado com sucesso!', objeto: 'Preço'} }        
          format.json { head :no_content }
        else
          format.html { render action: 'index' }
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

  def get_parametros_preco

    if(request.original_url.include? "preco_servicos")

      if (!(params[:produto].nil?) && !(params[:analise].nil?))
        @precos = PrecoServico.where(:analise => params[:analise], :produto => params[:produto])

        @parametros_preco = []
        existentes = [""]
        

        @precos.each do |preco|
          existentes.push( preco.parametro )
        
        end

        @parametros_preco = Parametro.where("nome NOT IN (?)", existentes)

      else

        @parametros_preco = []        

      end

    end

  end

  private
    def set_grid
      @precos_grid = initialize_grid(PrecoServico,
        :order => 'created_at',
        :order_direction => 'desc',
        :per_page => 10
      )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_preco_servico
      @preco_servico = PrecoServico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preco_servico_params
      params.require(:preco_servico).permit(:id, :analise, :parametro, :produto, :preco)
    end
end