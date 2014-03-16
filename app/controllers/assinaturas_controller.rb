class AssinaturasController < ApplicationController
  before_action :set_assinatura, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao

  # GET /assinaturas
  # GET /assinaturas.json
  def index
    @assinaturas = Assinatura.all
    @assinaturas_grid = initialize_grid(Assinatura, 
      :order => 'created_at',
      :order_direction => 'desc',
      :per_page => 10
    )
  end

  # GET /assinaturas/1
  # GET /assinaturas/1.json
  def show
  end

  # GET /assinaturas/new
  def new
    @assinatura = Assinatura.new
  end

  # GET /assinaturas/1/edit
  def edit
  end

  # POST /assinaturas
  # POST /assinaturas.json
  def create
    @assinatura = Assinatura.new(assinatura_params)

    respond_to do |format|
      if @assinatura.save
        format.html { redirect_to @assinatura, notice: 'Assinatura criada com sucesso!' }
        format.json { render action: 'show', status: :created, location: @assinatura }
      else
        format.html { render action: 'new' }
        format.json { render json: @assinatura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assinaturas/1
  # PATCH/PUT /assinaturas/1.json
  def update
    respond_to do |format|
      if @assinatura.update(assinatura_params)
        format.html { redirect_to @assinatura, notice: 'Assinatura atualizada com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assinatura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assinaturas/1
  # DELETE /assinaturas/1.json
  def destroy
    @assinatura.destroy
    respond_to do |format|
      format.html { redirect_to assinaturas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assinatura
      @assinatura = Assinatura.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assinatura_params
      params.require(:assinatura).permit(:nome, :tipo_conselho, :numero_conselho)
    end
end
