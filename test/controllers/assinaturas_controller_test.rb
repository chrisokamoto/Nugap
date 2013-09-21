require 'test_helper'

class AssinaturasControllerTest < ActionController::TestCase
  setup do
    @assinatura = assinaturas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assinaturas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assinatura" do
    assert_difference('Assinatura.count') do
      post :create, assinatura: { crfmg: @assinatura.crfmg, nome: @assinatura.nome }
    end

    assert_redirected_to assinatura_path(assigns(:assinatura))
  end

  test "should show assinatura" do
    get :show, id: @assinatura
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assinatura
    assert_response :success
  end

  test "should update assinatura" do
    patch :update, id: @assinatura, assinatura: { crfmg: @assinatura.crfmg, nome: @assinatura.nome }
    assert_redirected_to assinatura_path(assigns(:assinatura))
  end

  test "should destroy assinatura" do
    assert_difference('Assinatura.count', -1) do
      delete :destroy, id: @assinatura
    end

    assert_redirected_to assinaturas_path
  end
end
