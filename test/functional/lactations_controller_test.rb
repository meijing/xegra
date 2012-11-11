require 'test_helper'

class LactationsControllerTest < ActionController::TestCase
  setup do
    @lactation = lactations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lactations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lactation" do
    assert_difference('Lactation.count') do
      post :create, lactation: { cell: @lactation.cell, date: @lactation.date, greasy_kg: @lactation.greasy_kg, greasy_percentage: @lactation.greasy_percentage, lactation_duration: @lactation.lactation_duration, milk_kg: @lactation.milk_kg, protein_kg: @lactation.protein_kg, protein_percentage: @lactation.protein_percentage }
    end

    assert_redirected_to lactation_path(assigns(:lactation))
  end

  test "should show lactation" do
    get :show, id: @lactation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lactation
    assert_response :success
  end

  test "should update lactation" do
    put :update, id: @lactation, lactation: { cell: @lactation.cell, date: @lactation.date, greasy_kg: @lactation.greasy_kg, greasy_percentage: @lactation.greasy_percentage, lactation_duration: @lactation.lactation_duration, milk_kg: @lactation.milk_kg, protein_kg: @lactation.protein_kg, protein_percentage: @lactation.protein_percentage }
    assert_redirected_to lactation_path(assigns(:lactation))
  end

  test "should destroy lactation" do
    assert_difference('Lactation.count', -1) do
      delete :destroy, id: @lactation
    end

    assert_redirected_to lactations_path
  end
end
