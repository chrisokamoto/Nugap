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

  def index
  	if valida_id_sessao
      redirect_to home_path
  	else
  		redirect_to login_path
  	end
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