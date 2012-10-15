require 'test_helper'

class KineControllerTest < ActionController::TestCase
  setup do
    @cow = kine(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kine)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cow" do
    assert_difference('Cow.count') do
      post :create, cow: { father: @cow.father, name: @cow.name, num_borns: @cow.num_borns, ring: @cow.ring, years: @cow.years }
    end

    assert_redirected_to cow_path(assigns(:cow))
  end

  test "should show cow" do
    get :show, id: @cow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cow
    assert_response :success
  end

  test "should update cow" do
    put :update, id: @cow, cow: { father: @cow.father, name: @cow.name, num_borns: @cow.num_borns, ring: @cow.ring, years: @cow.years }
    assert_redirected_to cow_path(assigns(:cow))
  end

  test "should destroy cow" do
    assert_difference('Cow.count', -1) do
      delete :destroy, id: @cow
    end

    assert_redirected_to kine_path
  end
end
