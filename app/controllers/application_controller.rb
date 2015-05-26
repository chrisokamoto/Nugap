class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :user_is_administrador?, :user_is_tecnico?, :user_is_estagiario?, 
  :valida_id_sessao

  def valida_id_sessao
    !session[:id].nil?
  end

  def valida_sessao
  	redirect_to login_path, :flash => {error: "Você não está logado!"} unless valida_id_sessao
  end

  def valida_sessao_nao_permitida
    redirect_to login_path
  end

  def limpa_sessao_preco
    session[:is_from_limpa_sessao] = nil
    session[:preco_params] = nil   
  end

  def seta_sessao_copy_to_false
    session[:is_from_copy] = false    
  end

  def limpa_sessao_id_orcamento
    session[:id_orcamento] = nil
  end

  def index
  	if valida_id_sessao
      redirect_to home_path
  	else
  		redirect_to login_path
  	end
  end

  def paginacao
    def left?
      @paginacao_left_page >= 0
    end
    def left
      @paginacao_left_page+1
    end
    def right?
      @paginacao_right__page >= 0
    end
    def right
      @paginacao_right__page+1
    end

  end

  def set_page
    if params[:page].nil?
      @page = 0
    else
      @page = params[:page].to_i-1
    end
  end

  def get_page
    @page
  end

  def set_paginacao(dados)
      set_page
      pagina_atual  = get_page
      limite_dados  = 10.0
      total         = dados.count
      dados_retorno = []
      paginas = (total/limite_dados).ceil.to_i
      paginas_esquerda = pagina_atual
      paginas_direita = paginas - pagina_atual - 1
      @mypages = []

      # Filtra os dados
      for counter in 0..limite_dados-1
        break if dados[pagina_atual*10 + counter].nil?
        dados_retorno << dados[pagina_atual*10 + counter]
      end

      # Adiciona as paginas a esquerda
      i = 0, t = pagina_atual - 2
      if paginas_direita < 2
        t = t - (2 - paginas_direita)
      end
      t = 0 if t < 0
      for i in t..pagina_atual-1
        @mypages << [i, false]
      end

      # Adiciona a pagina atual
      @mypages << [pagina_atual, true]

      # Adiciona as paginas a direita
      i = 0, t = 10 - @mypages.count
      if paginas_direita < t
        t = paginas_direita
      end
      for i in 1..t
        @mypages << [pagina_atual + i, false]
      end

      # Seta variaveis de auxilio ao view
      @paginacao_left_page = pagina_atual-1
      @paginacao_right_page = pagina_atual+1
      if @paginacao_right_page == paginas
        @paginacao_right_page = -1
      end

      dados_retorno
  end

  

  def user_is_administrador?
    Usuario.find_by_id(session[:id]).is_administrador?
  end

  def user_is_tecnico?
    Usuario.find_by_id(session[:id]).is_tecnico?
  end

  def user_is_estagiario?
    Usuario.find_by_id(session[:id]).is_estagiario?
  end

  def valida_permissao_adm
    redirect_to root_path unless user_is_administrador?
  end

  

end