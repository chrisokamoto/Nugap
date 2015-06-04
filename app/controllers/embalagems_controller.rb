class EmbalagemsController < ApplicationController
  before_action :set_embalagem, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao
  before_action :set_grid, only: [:index, :create, :edit, :update] 
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
  before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]
  before_action :limpa_sessao_id_amostra, only:[:show, :edit, :index, :new]  

  # GET /embalagems
  # GET /embalagems.json
  def index
    @embalagems = Embalagem.all
    @embalagem = Embalagem.new
    @embalagens_grid = initialize_grid(Embalagem, 
      :order => 'created_at',
      :order_direction => 'desc',
      :per_page => 10
    )
  end

  # GET /embalagems/1
  # GET /embalagems/1.json
  def show
  end

  # GET /embalagems/new
  def new
    @embalagem = Embalagem.new
  end

  # GET /embalagems/1/edit
  def edit
  end

  # POST /embalagems
  # POST /embalagems.json
  def create
    @embalagem = Embalagem.new(embalagem_params)

    respond_to do |format|
      if @embalagem.save
        format.html { redirect_to embalagems_path, notice: 'Embalagem criada com sucesso!' }
        format.json { render action: 'index', status: :created, location: @embalagem }
      else
        format.html { render action: 'new' }
        format.json { render json: @embalagem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /embalagems/1
  # PATCH/PUT /embalagems/1.json
  def update
    respond_to do |format|
      if @embalagem.update(embalagem_params)
        format.html { redirect_to embalagems_path, notice: 'Embalagem atualizada com sucesso!' }
        format.json { head :no_content }
      else
        format.html { render action: 'index' }
        format.json { render json: @embalagem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /embalagems/1
  # DELETE /embalagems/1.json
  def destroy
    @embalagem.destroy
    respond_to do |format|
      format.html { redirect_to embalagems_url }
      format.json { head :no_content }
    end
  end

  private
    def set_grid
      @embalagens_grid = initialize_grid(Embalagem,
        :order => 'created_at',
        :order_direction => 'desc',
        :per_page => 10
      )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_embalagem
      @embalagem = Embalagem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def embalagem_params
      params.require(:embalagem).permit(:tipo)
    end
end
