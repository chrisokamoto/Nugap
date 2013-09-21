require 'test_helper'

class ParametroResultadosControllerTest < ActionController::TestCase
  setup do
    @parametro_resultado = parametro_resultados(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parametro_resultados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parametro_resultado" do
    assert_difference('ParametroResultado.count') do
      post :create, parametro_resultado: { analise_id: @parametro_resultado.analise_id, parametro_id: @parametro_resultado.parametro_id, resultado: @parametro_resultado.resultado }
    end

    assert_redirected_to parametro_resultado_path(assigns(:parametro_resultado))
  end

  test "should show parametro_resultado" do
    get :show, id: @parametro_resultado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parametro_resultado
    assert_response :success
  end

  test "should update parametro_resultado" do
    patch :update, id: @parametro_resultado, parametro_resultado: { analise_id: @parametro_resultado.analise_id, parametro_id: @parametro_resultado.parametro_id, resultado: @parametro_resultado.resultado }
    assert_redirected_to parametro_resultado_path(assigns(:parametro_resultado))
  end

  test "should destroy parametro_resultado" do
    assert_difference('ParametroResultado.count', -1) do
      delete :destroy, id: @parametro_resultado
    end

    assert_redirected_to parametro_resultados_path
  end
end
