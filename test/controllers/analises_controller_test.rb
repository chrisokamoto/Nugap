require 'test_helper'

class AnalisesControllerTest < ActionController::TestCase
  setup do
    @analise = analises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:analises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create analise" do
    assert_difference('Analise.count') do
      post :create, analise: { tipo: @analise.tipo }
    end

    assert_redirected_to analise_path(assigns(:analise))
  end

  test "should show analise" do
    get :show, id: @analise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @analise
    assert_response :success
  end

  test "should update analise" do
    patch :update, id: @analise, analise: { tipo: @analise.tipo }
    assert_redirected_to analise_path(assigns(:analise))
  end

  test "should destroy analise" do
    assert_difference('Analise.count', -1) do
      delete :destroy, id: @analise
    end

    assert_redirected_to analises_path
  end
end
