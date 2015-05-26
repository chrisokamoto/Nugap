class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :valida_sessao, :valida_permissao_adm
  before_action :set_grid, only: [:index, :create, :edit, :update] 
  before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new] 
  before_action :seta_sessao_copy_to_false, only:[:show, :edit, :index, :new]   
  before_action :limpa_sessao_id_orcamento, only:[:show, :edit, :index, :new]

  before_filter :valida_permissao_chrisfernando, only: [:show, :edit, :update, :destroy]


  def valida_permissao_chrisfernando
    if session[:id] != 1
      if @usuario.id == 1
        redirect_to root_path
      end
    end
  end

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all
    @usuario = Usuario.new
    
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end


  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to usuarios_path, notice: 'Usuário criado com sucesso!' }
        format.json { render action: 'index', status: :created, location: @usuario }
      else
        format.html { render action: 'new' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    respond_to do |format|
      puts usuario_params
      if @usuario.update(usuario_params)        
        format.html { redirect_to usuarios_path, notice: 'Usuário atualizado com sucesso!' }
        format.json { head :no_content }
      else        
        format.html { render action: 'index' }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_url }
      format.json { head :no_content }
    end
  end

  private
    def set_grid
      usuarios = Usuario.where.not(id:1)
      @usuarios_grid = initialize_grid(usuarios,
        :order => 'created_at',
        :order_direction => 'desc',
        :per_page => 10
      )
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:login, :nome, :senha, :sobrenome, :confirmacao, :permissao)
    end
end
