require 'test_helper'

class ReproductionSimbolsControllerTest < ActionController::TestCase
  setup do
    @reproduction_simbol = reproduction_simbols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reproduction_simbols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reproduction_simbol" do
    assert_difference('ReproductionSimbol.count') do
      post :create, reproduction_simbol: { meaning: @reproduction_simbol.meaning, simbol: @reproduction_simbol.simbol }
    end

    assert_redirected_to reproduction_simbol_path(assigns(:reproduction_simbol))
  end

  test "should show reproduction_simbol" do
    get :show, id: @reproduction_simbol
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reproduction_simbol
    assert_response :success
  end

  test "should update reproduction_simbol" do
    put :update, id: @reproduction_simbol, reproduction_simbol: { meaning: @reproduction_simbol.meaning, simbol: @reproduction_simbol.simbol }
    assert_redirected_to reproduction_simbol_path(assigns(:reproduction_simbol))
  end

  test "should destroy reproduction_simbol" do
    assert_difference('ReproductionSimbol.count', -1) do
      delete :destroy, id: @reproduction_simbol
    end

    assert_redirected_to reproduction_simbols_path
  end
end
