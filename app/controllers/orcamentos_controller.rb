class OrcamentosController < ApplicationController
  before_action :set_orcamento, only: [:show, :edit, :update, :destroy]  
  before_action :valida_sessao

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
    get_analises
    get_parametros
    get_valor_unitario
    get_valor_total
    get_valor_impostos
    get_telefone_empresa

  end

  # GET /orcamentos/1/edit
  def edit
    @orcamento = Orcamento.find(params[:id]) 
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

    @id_number = params[:id_number]
    
    @preco_unitario = getPrecoUnitarioServico(params[:produto], params[:analise], params[:parametro])    
    @preco_unitario 

  end

  def get_valor_total    

    @preco_total = 0
    @tem_quantidade = 0   
    @id_number = params[:id_number] 


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
    
    @preco_desconto 

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

  # POST /orcamentos
  # POST /orcamentos.json
  def create
    @orcamento = Orcamento.new(orcamento_params)    

    respond_to do |format|
      if(!@orcamento.servico_orcamentos.nil?)        
         @orcamento.servico_orcamentos.each do |servico_orcamento|

          if !servico_orcamento.parametro.nil?

            parametro = Parametro.find_by_nome(servico_orcamento.parametro)
            servico_orcamento.metodo = parametro.metodo            

          end
        end
      end
      
      if @orcamento.save
        format.html { redirect_to @orcamento, notice: 'Orçamento criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @orcamento }
      else
        format.html { render action: 'new' }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end

    
  end

  # PATCH/PUT /orcamentos/1
  # PATCH/PUT /orcamentos/1.json
  def update
    respond_to do |format|
      
      if @orcamento.update(orcamento_params)
        format.html { redirect_to @orcamento, notice: 'Orçamento atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @orcamento.errors, status: :unprocessable_entity }
      end
    end

    atualizou_parametro = 0

      if(!@orcamento.servico_orcamentos.nil?)        
         @orcamento.servico_orcamentos.each do |servico_orcamento|

          if !servico_orcamento.parametro.nil?

            atualizou_parametro = 1;

            parametro = Parametro.find_by_nome(servico_orcamento.parametro)
            if !parametro.nil?
              servico_orcamento.metodo = parametro.metodo            
            end


          end
        end
      end

      if(atualizou_parametro == 1)

          @orcamento.update(params[:orcamento][:servico_orcamentos_attributes][:metodo])        
         

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
end
