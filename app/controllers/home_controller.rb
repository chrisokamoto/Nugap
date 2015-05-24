class HomeController < ApplicationController
	 before_action :valida_sessao
	 before_action :limpa_sessao_preco, only:[:show, :edit, :index, :new]
	 
	  def index

	  end

	  def show

	  end
end
