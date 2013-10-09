class AmostrasController < ApplicationController
  before_action :set_amostra, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao

  # GET /amostras
  # GET /amostras.json
  def index
    @amostras = Amostra.all
  end

  # GET /amostras/1
  # GET /amostras/1.json
  def show
	@amostra = Amostra.find(params[:id])
	
	respond_to do |format|
	format.html # show.html.erb
	format.xml  { render :xml => @amostra }
	format.pdf { render :layout => false } # Add this line
	prawnto :filename => "laudo #{@amostra.certificado} #{@amostra.produto} #{@amostra.marca}", :prawn => {  
      		#:background => "public/image/logo2.png",          
      		#:left_margin => 0,  
     		#:right_margin => 0,  
     		:top_margin => 50,  
     		:bottom_margin => 70,  
     		:page_size => 'A4' 
	}
	end

  end

  # GET /amostras/new
  def new
    @amostra = Amostra.new
  end

  # GET /amostras/1/edit
  def edit
    @amostra = Amostra.find(params[:id])  
  end

  # POST /amostras
  # POST /amostras.json
  def create
    @amostra = Amostra.new(amostra_params)

    respond_to do |format|

      if !@amostra.fabricante.nil?

        fabricante = Empresa.find_by_nome(@amostra.fabricante)
        @amostra.fabricante_rua = fabricante.rua
        @amostra.fabricante_numero = fabricante.numero
        @amostra.fabricante_bairro = fabricante.bairro
        @amostra.fabricante_cidade = fabricante.cidade
        @amostra.fabricante_UF = fabricante.UF
        @amostra.fabricante_CEP = fabricante.CEP
        @amostra.fabricante_CNPJ = fabricante.CNPJ
        @amostra.fabricante_telefone = fabricante.telefone

      end

      if !@amostra.solicitante.nil?

        solicitante = Empresa.find_by_nome(@amostra.solicitante)
        @amostra.solicitante_rua = solicitante.rua
        @amostra.solicitante_numero = solicitante.numero
        @amostra.solicitante_bairro = solicitante.bairro
        @amostra.solicitante_cidade = solicitante.cidade
        @amostra.solicitante_UF = solicitante.UF
        @amostra.solicitante_CEP = solicitante.CEP
        @amostra.solicitante_CNPJ = solicitante.CNPJ
        @amostra.solicitante_telefone = solicitante.telefone

      end

      if !@amostra.assinatura.nil?

        assinatura = Assinatura.find_by_nome(@amostra.assinatura)
        @amostra.assinatura_tipo_conselho = assinatura.tipo_conselho
        @amostra.assinatura_numero_conselho = assinatura.numero_conselho

      end

      if(!@amostra.parametro_resultados.nil?)
         @amostra.parametro_resultados.each do |parametro_resultado|

          if !parametro_resultado.parametro.nil?

            parametro = Parametro.find_by_nome(parametro_resultado.parametro)
            parametro_resultado.referencia_parametro = parametro.referencia
            parametro_resultado.metodo_parametro = parametro.metodo
            parametro_resultado.valor_referencia_parametro = parametro.valor_referencia

          end
        end
      end

      if @amostra.save

        format.html { redirect_to @amostra, notice: 'Amostra criada com sucesso!' }
        format.json { render action: 'show', status: :created, location: @amostra }
      else
        format.html { render action: 'new' }
        format.json { render json: @amostra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amostras/1
  # PATCH/PUT /amostras/1.json
  def update
    respond_to do |format|

      if !params[:amostra][:fabricante].nil?

        fabricante = Empresa.find_by_nome(params[:amostra][:fabricante])
        if !fabricante.nil?
          params[:amostra][:fabricante_rua] = fabricante.rua
          params[:amostra][:fabricante_numero] = fabricante.numero
          params[:amostra][:fabricante_bairro] = fabricante.bairro
          params[:amostra][:fabricante_cidade] = fabricante.cidade
          params[:amostra][:fabricante_UF] = fabricante.UF
          params[:amostra][:fabricante_CEP] = fabricante.CEP
          params[:amostra][:fabricante_CNPJ] = fabricante.CNPJ
          params[:amostra][:fabricante_telefone] = fabricante.telefone
        end

      end

      if !params[:amostra][:solicitante].nil?

        solicitante = Empresa.find_by_nome(params[:amostra][:solicitante])
        if !solicitante.nil?
          params[:amostra][:solicitante_rua] = solicitante.rua
          params[:amostra][:solicitante_numero] = solicitante.numero
          params[:amostra][:solicitante_bairro] = solicitante.bairro
          params[:amostra][:solicitante_cidade] = solicitante.cidade
          params[:amostra][:solicitante_UF] = solicitante.UF
          params[:amostra][:solicitante_CEP] = solicitante.CEP
          params[:amostra][:solicitante_CNPJ] = solicitante.CNPJ
          params[:amostra][:solicitante_telefone] = solicitante.telefone
        end

      end

      if !params[:amostra][:assinatura].nil?

        assinatura = Assinatura.find_by_nome(params[:amostra][:assinatura])
        if !assinatura.nil?
          params[:amostra][:assinatura_tipo_conselho] = assinatura.tipo_conselho
          params[:amostra][:assinatura_numero_conselho] = assinatura.numero_conselho
        end

      end

      if @amostra.update(amostra_params)
        

        format.html { redirect_to @amostra, notice: 'Amostra atualizada com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @amostra.errors, status: :unprocessable_entity }
      end
    end
     
     atualizou_parametro = 0

      if(!@amostra.parametro_resultados.nil?)
         @amostra.parametro_resultados.each do |parametro_resultado|

          if !parametro_resultado.parametro.nil?

            atualizou_parametro = 1;

            parametro = Parametro.find_by_nome(parametro_resultado.parametro)
            parametro_resultado.referencia_parametro = parametro.referencia
            parametro_resultado.metodo_parametro = parametro.metodo
            parametro_resultado.valor_referencia_parametro = parametro.valor_referencia

          end
        end
      end

      if(atualizou_parametro == 1)

          @amostra.update(params[:amostra][:parametro_resultados_attributes][:referencia_parametro])        
          @amostra.update(params[:amostra][:parametro_resultados_attributes][:metodo_parametro])        
          @amostra.update(params[:amostra][:parametro_resultados_attributes][:valor_referencia_parametro])

      end
  end

  # DELETE /amostras/1
  # DELETE /amostras/1.json
  def destroy
    deletar_parametro = 0

    if(!@amostra.parametro_resultados.nil?)
      @parametro_resultados = ParametroResultado.find_by_amostra_id(@amostra.id)
      deletar_parametro = 1
    end

    if(deletar_parametro == 1)
      if !@parametro_resultados.nil? 
      @parametro_resultados.destroy
    end
    
    @amostra.destroy
    respond_to do |format|
      format.html { redirect_to amostras_url }
      format.json { head :no_content }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amostra
      @amostra = Amostra.find(params[:id])
    end

    def set_parametro_resultado
      @parametro_resultado = ParametroResultado.find_by_amostra_id(@amostra.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    private
    def amostra_params
      params.require(:amostra).permit(:data_fabricacao, :data_validade, :lote, :conteudo, 
        :descricao, :caracteristicas, :observacao, :solicitante, :fabricante, :produto, 
        :embalagem, :assinatura, :unidade, :status, :certificado, :marca, :data_entrada, 
        :data_saida, :observacoes, :fabricante_rua, :fabricante_numero, :fabricante_bairro, 
          :fabricante_cidade, :fabricante_UF, :fabricante_CEP, :fabricante_CNPJ,
          :fabricante_telefone, :solicitante_rua, :solicitante_numero, :solicitante_bairro,
          :solicitante_cidade, :solicitante_UF, :solicitante_CEP, :solicitante_CNPJ,
          :solicitante_telefone, :assinatura_tipo_conselho, :assinatura_numero_conselho, 
          :descricao_pedido, :fabricacao_informada, :validade_informada,           
        parametro_resultados_attributes: [:id, :conclusao, :parametro, :resultado, :amostra_id,
          :tipo, :referencia_parametro, :metodo_parametro, :valor_referencia_parametro, 
          :_destroy])
    end

end
