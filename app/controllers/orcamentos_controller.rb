class OrcamentosController < ApplicationController
  before_action :set_orcamento, only: [:show, :edit, :update, :destroy]  
  before_action :valida_sessao
  before_action :set_grid, only: [:index, :create, :edit, :update, :new, :get_valor_impostos]
  before_action :set_is_new_or_create, only:[:new, :create]
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new] 
  before_action :limpa_sessao_id_orcamento, only:[:index, :new] 
  before_action :limpa_sessao_id_amostra, only:[:show, :edit, :index, :new]    

  # GET /orcamentos
  # GET /orcamentos.json
  def index
    @orcamentos = Orcamento.all
    @orcamentos_grid = initialize_grid(Orcamento, 
      :order => 'created_at',
      :order_direction => 'desc',
      :per_page => 10
    )
  end

  # GET /orcamentos/1
  # GET /orcamentos/1.json
  def show
    @orcamento = Orcamento.find(params[:id]) 
    @servico_orcamento = ServicoOrcamento.find_by_orcamento_id(@orcamento.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @amostra }
      format.pdf { render :layout => false } # Add this line
      prawnto :filename => "orcamento_#{@orcamento.numero}.pdf", 
      :prawn => {  
            #:background => "public/image/logo2.png",          
            :left_margin => 0,  
            :right_margin => 0,  
            :top_margin => 30,  
            :bottom_margin => 30,  
            :page_size => 'A4' 
      }
    end
  end

  # GET /orcamentos/new
  def new
    @orcamento = Orcamento.new
    @servico_orcamento = ServicoOrcamento.new    

  end

  # GET /orcamentos/1/edit
  def edit
    session[:id_orcamento] = params[:id]    
    @orcamento = Orcamento.find(params[:id]) 
    @servico_orcamento = ServicoOrcamento.new 
    get_analises
    get_parametros
    get_valor_unitario
    get_valor_total
    get_valor_impostos
    get_telefone_empresa

  end


  
  def get_analises    

    if(request.original_url.include? "orcamentos")

      @produto = PrecoServico.where(:produto => params[:produto])    

      @analises = []
      existentes = [""]
      

      @produto.each do |produto|
        existentes.push( produto.analise )
      
      end

      @analises = TipoAnalise.where("tipo IN (?)", existentes)

    end
  end 

  def get_parametros

    if(request.original_url.include? "orcamentos")

      @produtoAnalise = PrecoServico.where(:produto => params[:produto], :analise => params[:analise])    

      @parametros = []
      existentes = [""]
      

      @produtoAnalise.each do |produtoAnalise|
        existentes.push( produtoAnalise.parametro )
      
      end
      

      @parametros = Parametro.where("nome IN (?)", existentes)

    end
  end 

  def get_valor_unitario

    @preco_unitario = getPrecoUnitarioServico(params[:produto], params[:analise], params[:parametro])    
    @preco_unitario 

  end

  def get_valor_total    

    @preco_total = 0
    @tem_quantidade = 0 

    if !params[:valor_unitario].nil? && !params[:qtd_amostra].nil?
   
      @preco_total = params[:valor_unitario].to_f * params[:qtd_amostra].to_f          
      @tem_quantidade = 1
      
    end    
    @preco_total 

  end

  def get_valor_desconto 

    @preco_desconto = 0

    if !params[:bruto].nil? && !params[:desconto].nil?
   
      @preco_desconto = params[:bruto].to_f - (params[:bruto].to_f * params[:desconto].to_f / 100.0)
      
    end    
    
    respond_to do |format|
      format.json { render json: @preco_desconto, status: :ok }
    end

  end

  def get_valor_impostos     

    @ir = 0  
    @pis = 0
    @cssl = 0
    @cofins = 0   
    @preco_total =  params[:total_pagar].to_f     

    if !params[:total_pagar].nil? 

      if params[:total_pagar].to_f >= 666.67
   
        @ir = params[:total_pagar].to_f * 1.5 / 100.0
        @preco_total = params[:total_pagar].to_f
        @preco_total  = @preco_total  - @ir

        if params[:total_pagar].to_f >= 5000
          @pis = params[:total_pagar].to_f * 0.65 / 100.0
          @cssl = params[:total_pagar].to_f * 1 / 100.0
          @cofins = params[:total_pagar].to_f * 3 / 100.0

          @preco_total = params[:total_pagar].to_f
          @preco_total  = @preco_total  - @ir - @pis - @cssl - @cofins
        end

      end
      
    end

  end

  def get_empresas
      respond_to do |format|
        if get_characters_param
          string = get_characters_param.downcase 

          dados = Empresa.where("lower(nome) LIKE ?" , "%#{string}%").pluck(:nome)
          format.json { render json: dados, status: :ok }
         else
            format.json { render json: nil, status: :unprocessable_entity }
          end
      end 
  end

  def get_characters_param
    params[:characters]
  end

  def get_telefone_empresa

    if !params[:empresa].nil? 
      empresa = Empresa.find_by_nome(params[:empresa])
      if !empresa.nil?
        @telefone = empresa.telefone        
      end
    end

  end

  def getPrecoUnitarioServico(produto, analise, parametro)      
    
    @servico = PrecoServico.where(:produto => produto,
      :analise => analise, 
      :parametro => parametro)

    @preco = 0   

    if !@servico.nil?  
      @servico.each do |servico|
                
        @preco = servico.preco
      end
    end

    @preco
    
  end

  def set_impostos_e_desconto total_pagar, id_orcamento
    @orcamento = Orcamento.where(id: id_orcamento).first
    @preco_desconto = total_pagar.to_f - (total_pagar.to_f * @orcamento.desconto.to_f / 100.0)

    @ir = 0  
    @pis = 0
    @cssl = 0
    @cofins = 0   
    @preco_total =  @preco_desconto.to_f     

    if !@preco_desconto.nil? 

      if @preco_desconto.to_f >= 666.67
   
        @ir = @preco_desconto.to_f * 1.5 / 100.0        
        @preco_total = @preco_desconto.to_f
        @preco_total  = @preco_total  - @ir - @pis - @cssl - @cofins

        if @preco_desconto.to_f >= 5000
          @pis = @preco_desconto.to_f * 0.65 / 100.0
          @cssl = @preco_desconto.to_f * 1 / 100.0
          @cofins = @preco_desconto.to_f * 3 / 100.0
          
          @preco_total = @preco_desconto.to_f
          @preco_total  = @preco_total  - @ir - @pis - @cssl - @cofins
        end

      end
      
    end

    @orcamento.total_pagar = @preco_total
    @orcamento.ir = @ir
    @orcamento.pis = @pis
    @orcamento.cssl = @cssl
    @orcamento.cofins = @cofins
    @orcamento.save
  end

  def get_valor_total_orcamento
    @valor_total = 0
    
    servicos_orcamentos = ServicoOrcamento.where(orcamento_id: params[:id])
    servicos_orcamentos.each do |servico|
      if(servico.valor_total)
        @valor_total += servico.valor_total
      end
    end

    if(params[:has_to_save])
      set_impostos_e_desconto(@valor_total, params[:id])
    end
    
    respond_to do |format|
      format.json { render json: @valor_total, status: :ok }
    end    
    
  end

  # POST /orcamentos
  # POST /orcamentos.json
  def create
    @orcamento = Orcamento.new(orcamento_params)    

    respond_to do |format|     
      
      if @orcamento.save
        format.html { redirect_to edit_orcamento_path(@orcamento) }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end

    
  end

  def saveVirtualServicoOrcamento 
      session[:id_orcamento] = params[:id]

      @servico_orcamento = ServicoOrcamento.new
      @servico_orcamento.produto = params[:produto] ? params[:produto] : params[:servico_orcamento][:produto]
      produto = params[:produto] ? params[:produto] : params[:servico_orcamento][:produto]
      @servico_orcamento.analise = params[:analise] ? params[:analise] : params[:servico_orcamento][:analise]
      analise = params[:analise] ? params[:analise] : params[:servico_orcamento][:analise]
      @servico_orcamento.parametro = params[:parametro] ? params[:parametro] : params[:servico_orcamento][:parametro]      
      parametro_servico = params[:parametro] ? params[:parametro] : params[:servico_orcamento][:parametro]      
      @servico_orcamento.qtd_amostra = params[:quantidade] ? params[:quantidade] : params[:servico_orcamento][:qtd_amostra]
      quantidade = params[:quantidade] ? params[:quantidade] : params[:servico_orcamento][:qtd_amostra]
      @servico_orcamento.valor_unitario = params[:valor_unitario] ? params[:valor_unitario] : params[:servico_orcamento][:valor_unitario]
      valor_unitario = params[:valor_unitario] ? params[:valor_unitario] : params[:servico_orcamento][:valor_unitario]
      @servico_orcamento.valor_total = params[:valor_total] ? params[:valor_total] : params[:servico_orcamento][:valor_total]      
      valor_total = params[:valor_total] ? params[:valor_total] : params[:servico_orcamento][:valor_total]      
      @servico_orcamento.orcamento_id = params[:id]  
      @orcamento = Orcamento.find(params[:id]) 

      parametro = Parametro.find_by_nome(@servico_orcamento.parametro)
      @servico_orcamento.metodo = parametro.metodo
      metodo = parametro.metodo

      respond_to do |format|
        if(params[:produto]) 
          if(!params[:id_servico].eql? "-1")            
            @servico_orcamento = ServicoOrcamento.where(id: params[:id_servico]).first
            @servico_orcamento.update(produto: produto, analise: analise, parametro: parametro_servico, qtd_amostra: quantidade, valor_unitario: valor_unitario, valor_total: valor_total, metodo: metodo)
            format.html { redirect_to @orcamento, notice: 'Orçamento criado com sucesso.' }
            format.json { head :no_content }
          elsif(@servico_orcamento.save)
            format.html { redirect_to @orcamento, notice: 'Orçamento criado com sucesso.' }
            format.json { head :no_content }
          else
            format.html { render action: 'edit' }    
            format.json { head :no_content }        
          end
        end
      end

  end

  def set_servico_edit
    @servico = ServicoOrcamento.where(id: params[:id]).first
    @servico   
  end

  def delete_servico
    @servico = ServicoOrcamento.where(id: params[:id]).first
    @servico.destroy   
  end

  # PATCH/PUT /orcamentos/1
  # PATCH/PUT /orcamentos/1.json
  def update
    respond_to do |format|
      
      if @orcamento.update(orcamento_params)
        format.html { redirect_to orcamentos_path, notice: 'Orçamento atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end

    
    
  end

  # DELETE /orcamentos/1
  # DELETE /orcamentos/1.json
  def destroy
    @orcamento.destroy
    respond_to do |format|
      format.html { redirect_to orcamentos_url }
      format.json { head :no_content }
    end


  end

  def set_is_new_or_create
    @is_new_or_create = true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orcamento      
      @orcamento = Orcamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orcamento_params
      params.require(:orcamento).permit(:numero, :data, :pagamento, :pessoa_solicitante, 
        :empresa_solicitante, :telefone, :email, :observacao, :total_pagar, :ir, :quantidade, 
        :prazo, :status, :valor_bruto, :desconto, :pis, :cssl, :cofins,
        servico_orcamentos_attributes: [:id, :produto, :parametro, :analise, :qtd_amostra,
          :valor_unitario, :valor_total, :metodo, :orcamento_id,:_destroy])
    end

    def set_grid
      id = !params[:id].nil? ? params[:id] : session[:id_orcamento]

      @servico_orcamento_grid = initialize_grid(ServicoOrcamento.where(orcamento_id: id),
        order: 'id',        
        order_direction: 'desc',
        per_page: 100
      )
    end
end
