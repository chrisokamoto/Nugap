require 'test_helper'

class TipoAnalisesControllerTest < ActionController::TestCase
  setup do
    @tipo_analise = tipo_analises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_analises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_analise" do
    assert_difference('TipoAnalise.count') do
      post :create, tipo_analise: { tipo: @tipo_analise.tipo }
    end

    assert_redirected_to tipo_analise_path(assigns(:tipo_analise))
  end

  test "should show tipo_analise" do
    get :show, id: @tipo_analise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_analise
    assert_response :success
  end

  test "should update tipo_analise" do
    patch :update, id: @tipo_analise, tipo_analise: { tipo: @tipo_analise.tipo }
    assert_redirected_to tipo_analise_path(assigns(:tipo_analise))
  end

  test "should destroy tipo_analise" do
    assert_difference('TipoAnalise.count', -1) do
      delete :destroy, id: @tipo_analise
    end

    assert_redirected_to tipo_analises_path
  end
end
