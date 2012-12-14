require 'test_helper'

class FacturationMilksControllerTest < ActionController::TestCase
  setup do
    @facturation_milk = facturation_milks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facturation_milks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facturation_milk" do
    assert_difference('FacturationMilk.count') do
      post :create, facturation_milk: { date: @facturation_milk.date, liters: @facturation_milk.liters }
    end

    assert_redirected_to facturation_milk_path(assigns(:facturation_milk))
  end

  test "should show facturation_milk" do
    get :show, id: @facturation_milk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facturation_milk
    assert_response :success
  end

  test "should update facturation_milk" do
    put :update, id: @facturation_milk, facturation_milk: { date: @facturation_milk.date, liters: @facturation_milk.liters }
    assert_redirected_to facturation_milk_path(assigns(:facturation_milk))
  end

  test "should destroy facturation_milk" do
    assert_difference('FacturationMilk.count', -1) do
      delete :destroy, id: @facturation_milk
    end

    assert_redirected_to facturation_milks_path
  end
end
