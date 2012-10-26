require 'test_helper'

class ReproductionsControllerTest < ActionController::TestCase
  setup do
    @reproduction = reproductions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reproductions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reproduction" do
    assert_difference('Reproduction.count') do
      post :create, reproduction: { comment: @reproduction.comment, month: @reproduction.month, year: @reproduction.year }
    end

    assert_redirected_to reproduction_path(assigns(:reproduction))
  end

  test "should show reproduction" do
    get :show, id: @reproduction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reproduction
    assert_response :success
  end

  test "should update reproduction" do
    put :update, id: @reproduction, reproduction: { comment: @reproduction.comment, month: @reproduction.month, year: @reproduction.year }
    assert_redirected_to reproduction_path(assigns(:reproduction))
  end

  test "should destroy reproduction" do
    assert_difference('Reproduction.count', -1) do
      delete :destroy, id: @reproduction
    end

    assert_redirected_to reproductions_path
  end
end
