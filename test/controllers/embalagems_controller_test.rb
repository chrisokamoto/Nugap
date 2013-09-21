require 'test_helper'

class EmbalagemsControllerTest < ActionController::TestCase
  setup do
    @embalagem = embalagems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:embalagems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create embalagem" do
    assert_difference('Embalagem.count') do
      post :create, embalagem: { tipo: @embalagem.tipo }
    end

    assert_redirected_to embalagem_path(assigns(:embalagem))
  end

  test "should show embalagem" do
    get :show, id: @embalagem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @embalagem
    assert_response :success
  end

  test "should update embalagem" do
    patch :update, id: @embalagem, embalagem: { tipo: @embalagem.tipo }
    assert_redirected_to embalagem_path(assigns(:embalagem))
  end

  test "should destroy embalagem" do
    assert_difference('Embalagem.count', -1) do
      delete :destroy, id: @embalagem
    end

    assert_redirected_to embalagems_path
  end
end
