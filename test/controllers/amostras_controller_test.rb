require 'test_helper'

class AmostrasControllerTest < ActionController::TestCase
  setup do
    @amostra = amostras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amostras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amostra" do
    assert_difference('Amostra.count') do
      post :create, amostra: { assinatura_id: @amostra.assinatura_id, caracteristicas: @amostra.caracteristicas, certificado: @amostra.certificado, conteudo: @amostra.conteudo, data_fabricacao: @amostra.data_fabricacao, data_validade: @amostra.data_validade, descricao: @amostra.descricao, embalagem_id: @amostra.embalagem_id, fabricante_id: @amostra.fabricante_id, lote: @amostra.lote, marca: @amostra.marca, produto_id: @amostra.produto_id, solicitante_id: @amostra.solicitante_id, status: @amostra.status, unidade: @amostra.unidade }
    end

    assert_redirected_to amostra_path(assigns(:amostra))
  end

  test "should show amostra" do
    get :show, id: @amostra
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amostra
    assert_response :success
  end

  test "should update amostra" do
    patch :update, id: @amostra, amostra: { assinatura_id: @amostra.assinatura_id, caracteristicas: @amostra.caracteristicas, certificado: @amostra.certificado, conteudo: @amostra.conteudo, data_fabricacao: @amostra.data_fabricacao, data_validade: @amostra.data_validade, descricao: @amostra.descricao, embalagem_id: @amostra.embalagem_id, fabricante_id: @amostra.fabricante_id, lote: @amostra.lote, marca: @amostra.marca, produto_id: @amostra.produto_id, solicitante_id: @amostra.solicitante_id, status: @amostra.status, unidade: @amostra.unidade }
    assert_redirected_to amostra_path(assigns(:amostra))
  end

  test "should destroy amostra" do
    assert_difference('Amostra.count', -1) do
      delete :destroy, id: @amostra
    end

    assert_redirected_to amostras_path
  end
end
