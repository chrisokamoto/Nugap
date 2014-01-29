require 'test_helper'

class PrecoServicosControllerTest < ActionController::TestCase
  setup do
    @preco_servico = preco_servicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preco_servicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preco_servico" do
    assert_difference('PrecoServico.count') do
      post :create, preco_servico: { analise: @preco_servico.analise, legislacao: @preco_servico.legislacao, parametro: @preco_servico.parametro, preco: @preco_servico.preco, produto: @preco_servico.produto }
    end

    assert_redirected_to preco_servico_path(assigns(:preco_servico))
  end

  test "should show preco_servico" do
    get :show, id: @preco_servico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preco_servico
    assert_response :success
  end

  test "should update preco_servico" do
    patch :update, id: @preco_servico, preco_servico: { analise: @preco_servico.analise, legislacao: @preco_servico.legislacao, parametro: @preco_servico.parametro, preco: @preco_servico.preco, produto: @preco_servico.produto }
    assert_redirected_to preco_servico_path(assigns(:preco_servico))
  end

  test "should destroy preco_servico" do
    assert_difference('PrecoServico.count', -1) do
      delete :destroy, id: @preco_servico
    end

    assert_redirected_to preco_servicos_path
  end
end
